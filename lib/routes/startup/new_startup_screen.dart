import 'dart:io';

import 'package:eds_funds/widgets/text_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:eds_funds/import.dart';

import 'package:http/http.dart' as http;

class NewStartupScreen extends StatefulWidget {
  @override
  _NewStartupScreenState createState() => _NewStartupScreenState();
}

class _NewStartupScreenState extends State<NewStartupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();
  final _teamMemberFormKey = GlobalKey<FormState>();
  final _db = Firestore.instance;
  final _category = Category();
  final _startup = Startup();
  FirebaseUser _currentUser;
  final _newMemberProfile =
      UsersProfile(address: null, firstName: null, lastName: null, tel: null);

  List<Map<String,dynamic>> _images = [];
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
      ;

      _teamMembers.add(pull['uid']);
      _teamMemberTextController.clear();
    });
  }

  void _addStartup() {
    if (!_formKey.currentState.validate()) {
      return showSnackBar(_scafoldKey, 'Fill in feilds to continue');
    } else if (_images.length < 3) {
      return showSnackBar(_scafoldKey, 'Minimue of three images is required');
    } else if (_teamMembers.length < 2) {
      return showSnackBar(
          _scafoldKey, 'Minimue of three two members is required');
    }

    _formKey.currentState.save();

    final bat = _db.batch();
    final docKey = getID();
    final timeStamp = DateTime.now().toUtc();
    final hash = getHash(
        '${_teamMembers.join()}${timeStamp}${_startup.name}${_startup.teamLeader}');

    final imagesUrl = _images.map((e) async {
      final url = await uploadFile(e['file'], 'startups');
      return url;
    }).toList();

    bat.setData(_db.collection('startup').document(docKey), {
      'teamLeader': _currentUser.uid,
      'teamMembers': _teamMembers,
      'name': _startup.name,
      'image': imagesUrl,
      'desc': _startup.desc,
      'category': _startup.category
    });
    _teamMembers.forEach((e) {
      bat.updateData(
          _db
              .collection('user')
              .document(e)
              .collection('startup')
              .document(docKey),
          {'id': docKey});
    });
  }

  Future<String> _getTeamMemberImage(String uid) async {
    if (uid == null) return getDefaultImageUrl('default');
    final e = await Firestore.instance.collection('user').document(uid).get();
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
          CupertinoButton(
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: _addStartup,
          )
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
