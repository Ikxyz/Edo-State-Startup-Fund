import 'dart:math';

import 'package:eds_funds/classes/user_profile_class.dart';
import 'package:eds_funds/import.dart';
import 'package:eds_funds/classes/start_up.dart';
import 'package:eds_funds/routes/startup/new_startup_screen.dart';
import 'package:eds_funds/widgets/profile_widget.dart';
import 'package:flutter/cupertino.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  _ProfileScreenState() {}
  _getUser() async {
    UsersProfile user;
    final mUser = await FirebaseAuth.instance.currentUser();
    if (mUser == null) {
      return print('no user');
    }
    final result =
        await Firestore.instance.collection('user').document(mUser.uid).get();
    if (!result.exists) {
      return print('no user data found');
    }
    print('found it: ${result.data}');

    user = UsersProfile.toObject(Map<String, dynamic>.from(result.data));
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _getUser(),
          builder: (context, AsyncSnapshot doc) {
            if (doc.hasData) {
              print('Data found ::: ${doc.data}');
              if (doc.data != null) {
                UsersProfile user = doc.data;
                return Container(child: new QuickActions(user));
              }
            }
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: CircularProgressIndicator(
                strokeWidth: 2,
              )),
            );
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class QuickActions extends StatelessWidget {
  UsersProfile user;
  QuickActions(this.user) {}
  Widget _buildAvatar(user) {
    if (user == null) {
      return Offstage();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        height: 120,
        child: Center(
          child: CachedNetworkImage(
              imageUrl: user.passport == null
                  ? getDefaultImageUrl(user.email)
                  : user.passport),
        ),
      ),
    );
  }

  Widget _buildListItem(String title, IconData iconData, VoidCallback action,
      {Color iconColor}) {
    if (iconColor == null) {
      iconColor = Colors.blue.shade900;
    }
    final textStyle = new TextStyle(
      color: Colors.black54,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      fontFamily: 'QuickSand',
    );

    return new InkWell(
      onTap: action,
      child: new Padding(
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              width: 35.0,
              height: 35.0,
              margin: const EdgeInsets.only(right: 10.0),
              decoration: new BoxDecoration(
                color: iconColor,
                borderRadius: new BorderRadius.circular(5.0),
              ),
              alignment: Alignment.center,
              child: new Icon(iconData, color: Colors.white, size: 24.0),
            ),
            new Text(title, style: textStyle),
            new Expanded(child: new Container()),
//            new IconButton(
//                icon: new Icon(Icons.chevron_right, color: Colors.black26),
//                onPressed: action)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: _buildAvatar(user),
            )),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              children: <Widget>[
                _buildListItem(
                    user == null ? '' : '${user.lastName} ${user.firstName}',
                    Icons.person,
                    () {}),
                _buildListItem(
                    user == null ? '' : '${user.email}', Icons.email, () {}),
                //   _buildListItem("Edit Profile", Icons.person, () {}),
                // _buildListItem("Favourites", Icons.favorite, () {}),
                // _buildListItem("About", Icons.info_outline, () {}),
                _buildListItem('Log out', Icons.power_settings_new, () {
                  $AppAuthState(context).dispatch(isAutheticated.signOut);
                }, iconColor: Colors.red)
              ],
            ),
          ),
          FlatButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed('/addStartup');
            },
            icon: Icon(Icons.add),
            label: Text(
              'Add Startups',
              style: mainTextStyle.copyWith(
                  color: Theme.of(context).indicatorColor),
            ),
            textColor: Theme.of(context).indicatorColor,
            shape: StadiumBorder(),
            textTheme: ButtonTextTheme.primary,
            padding: const EdgeInsets.all(15.0),
          ),
          new Container(
              constraints: const BoxConstraints(maxHeight: 120.0),
              margin: const EdgeInsets.only(top: 20.0),
              child: new Align(
                alignment: Alignment.centerLeft,
                child: FutureBuilder(
                  future: FirebaseAuth.instance.currentUser(),
                  builder: (context, futuerData) {
                    if (futuerData.hasData) {
                      if (futuerData.data != null) {
                        return StreamBuilder(
                          stream: db
                              .collection('user')
                              .document(futuerData.data.uid)
                              .collection('startup')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snap) {
                            if (snap.connectionState ==
                                    ConnectionState.active ||
                                snap.connectionState == ConnectionState.done) {
                              if (snap.data.documents.length == 0) {
                                return Container(
                                    child: Center(
                                        child: Text(
                                  'Does not belong to any startup '
                                  'yet',
                                  style: TextStyle(color: Colors.grey),
                                )));
                              }
                              return ListView(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(
                                    left: 10.0,
                                    bottom: 20.0,
                                    right: 10.0,
                                    top: 10.0),
                                scrollDirection: Axis.horizontal,
                                children: snap.data.documentChanges
                                    .map((docSnapshot) {
                                  // Startup startup = Startup.fromJson(
                                  //     Map<String, dynamic>.from(
                                  //         docSnapshot.document.data));
                                  return FutureBuilder(
                                    future: db
                                        .collection('startup')
                                        .document(
                                            docSnapshot.document.data['id'])
                                        .get(),
                                    builder: (context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            startupSnapshot) {
                                      if (startupSnapshot.hasData) {
                                        if (startupSnapshot.data.exists &&
                                            startupSnapshot.data.data != null) {
                                          final startup = StartupClass.fromJson(
                                              Map<String, dynamic>.from(
                                                  startupSnapshot.data.data));
                                          return _startupItem(startup,
                                              onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                'startupInfo/${startupSnapshot.data.documentID}');
                                          });
                                        }
                                      }
                                      return Offstage();
                                    },
                                  );
                                }).toList(),
                              );
                            }
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }
                    return Offstage();
                  },
                ),
              ))
        ]);
  }

  Widget _startupItem(StartupClass startup,
      {Function onPressed,
      Color color: Colors.blue,
      Gradient gradient,
      String backgroundImage: "assets/icons/ic_design.png"}) {
    if (gradient == null) {
      gradient = blueGradient;
    }
    final textStyle = new TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 18.0,
        fontFamily: 'QuickSand');
    backgroundImage = startup.image[Random.secure().nextInt(3)];
    return new GestureDetector(
      onTap: () {
        if (onPressed == null) return;
        onPressed();
      },
      child: new Container(
        margin: const EdgeInsets.only(right: 5.0, left: 5.0),
        width: 150.0,
        decoration: new BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                  color: Colors.black38,
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                  offset: new Offset(0.0, 1.0)),
            ],
            image: DecorationImage(
                image: CachedNetworkImageProvider(backgroundImage),
                fit: BoxFit.cover)),
        child: new Stack(
          children: <Widget>[
            new Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: new Text(startup.name, style: textStyle),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = new Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class HeaderGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

final mainTextStyle = new TextStyle(
  fontFamily: 'QuickSand',
  color: Colors.white,
  fontWeight: FontWeight.w700,
  fontSize: 20.0,
);

final subTextStyle = new TextStyle(
  fontFamily: 'QuickSand',
  fontSize: 16.0,
  color: Colors.white70,
  fontWeight: FontWeight.w700,
);

final blueGradient = const LinearGradient(colors: const <Color>[
  const Color(0xFF0075D1),
  const Color(0xFF00A2E3),
], stops: const <double>[
  0.4,
  0.6
], begin: Alignment.topRight, end: Alignment.bottomLeft);

final purpleGradient = const LinearGradient(
    colors: const <Color>[const Color(0xFF882DEB), const Color(0xFF9A4DFF)],
    stops: const <double>[0.5, 0.7],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

final redGradient = const LinearGradient(colors: const <Color>[
  const Color(0xFFBA110E),
  const Color(0xFFCF3110),
], stops: const <double>[
  0.6,
  0.8
], begin: Alignment.bottomRight, end: Alignment.topLeft);
