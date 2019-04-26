import 'dart:io';
import 'package:path/path.dart' as $path;
import 'package:eds_funds/widgets/text_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:eds_funds/import.dart';
import 'package:http/http.dart' as http;

class NewStartupScreen extends StatefulWidget {
  @override
  _NewStartupScreenState createState() => _NewStartupScreenState();
}

final _db = Firestore.instance;

class _NewStartupScreenState extends State<NewStartupScreen> {
  NewStartupScreen() {
    _db.settings(persistenceEnabled: true);
  }

  var _isWorking = false;
  final _formKey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();
  final _teamMemberFormKey = GlobalKey<FormState>();

  final _category = Category();
  final _startup = Startup();
  FirebaseUser _currentUser;
  final _newMemberProfile =
      UsersProfile(address: null, firstName: null, lastName: null, tel: null);

  List<Map<String, dynamic>> _images = [];
  List<String> _teamMembers = [];

  final _teamMemberTextController = TextEditingController();

  void _addImage() async {
    File file = await getImage(camera: false);

    setState(() {
      _images.add({'file': file, 'path': file.path});
      print(_images);
    });
  }

  void _addTeamMember() async {
    if (!_teamMemberFormKey.currentState.validate()) return;
    _teamMemberFormKey.currentState.save();

    if (_currentUser.email == _newMemberProfile.email.toString()) {
      showSnackBar(_scafoldKey, 'You are already a member');
      return print('You are already a member');
    }

    final profile = await http.post(
      'https://us-central1-edostartupfund.cloudfunctions.net/getUidFormEmail',
      headers: {
        'Accept': 'application/json',
      },
      body: {'email': _newMemberProfile.email.toString()},
    );

    if (profile.body == null) {
      return;
    }
    Map<String, dynamic> pull =
        Map<String, dynamic>.from(jsonDecode(profile.body));
    setState(() {
      if (_teamMembers.any((e) {
        return e == pull['uid'];
      })) {
        showSnackBar(_scafoldKey, 'Already added this members');
        return print('Already added this members');
      }

      _teamMembers.add(pull['uid']);
      _teamMemberTextController.clear();
    });
  }

  void _progress(bool e) {
    setState(() {
      _isWorking = e;
    });
  }

  Future _addStartup() async {
    _progress(true);
    // Validate form data
    if (!_formKey.currentState.validate()) {
      _progress(false);
      return showSnackBar(_scafoldKey, 'Fill in feilds to continue');
    } else if (_images.length < 3) {
      _progress(false);
      return showSnackBar(_scafoldKey, 'Minimue of three images is required');
    } else if (_teamMembers.length < 2) {
      _progress(false);
      return showSnackBar(
          _scafoldKey, 'Minimue of three two members is required');
    }

// save form data
    _formKey.currentState.save();

// add team leader to the list of members
    _addTeamLeaderToMemberList();

//Initialize data for upload
    final bat = _db.batch();
    final timeStamp = DateTime.now().toUtc();
    final hash = getHash(
        '${_teamMembers.join()}$timeStamp${_startup.name}${_startup.teamLeader}');
    final docKey = getID();
    final List<String> imagesUrl = [];

    await Future.forEach(_images, (a) async {
      try {
        final url = await _uploadStartupImage(a);
        imagesUrl.add(url);
      } on Exception catch (e) {
         print(e);
        _progress(false);
      }
    });

// add new startup data to Bacth
    try {
      _addDataToBacth(bat, docKey, imagesUrl, hash);
    } on Exception catch (e) {
      print(e);
      _progress(false);
    }

    try {
      await _commitStartupToDatabase(bat);
    } on Exception catch (e) {
       print(e);
      _progress(false);
    }
    _progress(false);
  }

  Future<String> _uploadStartupImage(Map<String, dynamic> e) async {
    final url = await uploadFile(e['file'], $path.basename(e['file'].path));
    return url;
  }

  Future _commitStartupToDatabase(WriteBatch bat) async {
    await bat.commit();
    showSnackBar(_scafoldKey, 'Success');
    Navigator.of(context).pop();
  }

  void _addDataToBacth(
      WriteBatch bat, String docKey, List<String> imagesUrl, String hash) {
    bat.setData(_db.collection('startup').document(docKey), {
      'teamLeader': _currentUser.uid.toString(),
      'teamMembers': _teamMembers,
      'name': _startup.name.toString(),
      'image': imagesUrl,
      'hash': hash.toString(),
      'desc': _startup.desc.toString(),
      'category': _startup.category.toString()
    });
    //add startup docKey to all team members
    _teamMembers.forEach((e) {
      bat.setData(
          _db
              .collection('user')
              .document(e)
              .collection('startup')
              .document(docKey),
          {'id': docKey});
    });
    print(imagesUrl);
    print({
      'teamLeader': _currentUser.uid.toString(),
      'teamMembers': _teamMembers.toString(),
      'name': _startup.name.toString(),
      'image': imagesUrl.toString(),
      'hash': hash.toString(),
      'desc': _startup.desc.toString(),
      'category': _startup.category.toString()
    });
  }

  void _addTeamLeaderToMemberList() {
    _teamMembers.add(_currentUser.uid.toString());
  }

  Future<String> _getTeamMemberImage(String uid) async {
    if (uid == null) return getDefaultImageUrl('default');
    final e = await _db.collection('user').document(uid).get();
    if (e.exists) {
      UsersProfile _profile = UsersProfile.toObject(e.data);
      print('Profile found ${e.data}');
      if (e.data['passport'] != null) {
        return e.data['passport'];
      }
      return getDefaultImageUrl(e.data['email']);
    }
    return '';
  }

  Widget buildEnterName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onSaved: (val) {
          _startup.name = val;
        },
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
          isDense: true,
          hintText: "Enter Start-up Name",
        ),
        validator: (value) =>
            (value.isNotEmpty) ? null : 'Please fill this filed',
      ),
    );
  }

  Widget buildEnterDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        maxLength: 260,
        maxLines: 5,
        onSaved: (val) {
          _startup.desc = val;
        },
        autocorrect: true,
        decoration: const InputDecoration(
          filled: true,
          isDense: true,
          hintText: "Captivate investors with a brief introduction",
        ),
      ),
    );
  }

  Widget buildSelectCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: DropdownButtonFormField(
        hint: Text(_startup.category == null ? 'Select' : _startup.category),
        onChanged: (val) {
          setState(() {
            _startup.category = val;
          });
        },
        onSaved: (val) {
          _startup.category = val;
        },
        validator: isNotNull,
        items: _category.generate.map((e) {
          return DropdownMenuItem(
            child: Text(e.title),
            value: e.title,
          );
        }).toList(),
      ),
    );
  }

  @override
  void initState() {
    _fecthUser();
    super.initState();
  }

  void _fecthUser() async {
    _currentUser = await FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        title: Text(
          'Register Your startup',
          style:
              TextStyle(fontFamily: 'QuickSand', fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Visibility(
              visible: _isWorking,
              child: Center(
                  child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 2,
                ),
              )),
              replacement: CupertinoButton(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                onPressed: _addStartup,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextHeader(
                title: 'Start-up Name',
                trailing: '',
              ),
              buildEnterName(),
              TextHeader(
                title: 'StartUp Category',
                trailing: '',
              ),
              buildSelectCategory(),
              TextHeader(
                title: 'Start-up Description',
                trailing: '',
              ),
              buildEnterDescription(),
              TextHeader(
                title: 'Start-up photo gallery',
                trailing: '',
              ),
              new Container(
                height: 80.0,
                width: getWidth(context),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      height: 80,
                      child: Row(
                        children: _images.map((e) {
                          return GalleryImageItem(
                            src: e['path'],
                            tag: getID(length: 6),
                          );
                        }).toList(),
                      ),
                    ),
                    AddNewImage(onPressed: _addImage)
                  ],
                ),
              ),
              TextHeader(
                title: 'Add Team Members',
                trailing: '',
              ),
              Form(
                key: _teamMemberFormKey,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: _teamMemberTextController,
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                        onSaved: (val) {
                          _newMemberProfile.email = val;
                        },
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: "Enter team member email address",
                        ),
                        validator: isEmail,
                      ),
                    ),
                    RaisedButton(
                      onPressed: _addTeamMember,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      shape: CircleBorder(),
                      color: Colors.blueGrey,
                    )
                  ],
                ),
              ),
              new Container(
                height: 40.0,
                width: getWidth(context),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      height: 80,
                      child: Row(
                        children: _teamMembers.map((e) {
                          return TeamAvatar(_getTeamMemberImage(e));
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50.0,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 5.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddNewImage extends StatelessWidget {
  const AddNewImage({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      margin: const EdgeInsets.only(right: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[100],
        child: InkWell(
          onTap: onPressed,
          child: Icon(
            Icons.add_a_photo,
            size: 24.0,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class GalleryImageItem extends StatelessWidget {
  GalleryImageItem({
    Key key,
    @required this.tag,
    @required this.src,
    double size,
  });

  final String tag;
  final String src;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Container(
        width: 80.0,
        margin: const EdgeInsets.only(right: 8.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Material(
                color: Colors.white,
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Ink.image(
                  image: AssetImage(src),
                  fit: BoxFit.cover,
                  child: InkWell(
                    onTap: () {},
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TeamAvatar extends StatelessWidget {
  Future<String> image;

  TeamAvatar(this.image);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: image,
      builder: (context, AsyncSnapshot<String> data) {
        if (data.hasData) {
          print('Image Data = ${data.data}');
          return Padding(
            padding: EdgeInsets.all(4.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(data.data),
            ),
          );
        }
        return Offstage();
      },
    );
  }
}
