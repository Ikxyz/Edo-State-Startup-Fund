import 'dart:math';

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
  Widget sampleItem() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
            color: Colors.blue.shade900,
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Virtual Shops',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: 'QuickSand',
                ),
              ),
              Text(
                '\$1000',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w900,
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.style,
                        size: 60.0,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: MaterialButton(
                  onPressed: () {},
                  child: Text('View Project'),
                  color: Colors.red,
                  padding: EdgeInsets.all(8.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAppBar(Size size) {
    return new SliverAppBar(
      title: Text(
        'User Profile',
        style: TextStyle(
          fontFamily: 'QuickSand',
          fontWeight: FontWeight.bold,
        ),
      ),
      expandedHeight: MediaQuery.of(context).size.height * 0.4,
      elevation: 0.1,
      forceElevated: false,
      pinned: true,
      leading: CupertinoButton(
        child: Icon(
          CupertinoIcons.back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        CupertinoButton(
          child: Icon(
            CupertinoIcons.pen,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        CupertinoButton(
          child: Icon(
            CupertinoIcons.add_circled_solid,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return NewStartupScreen();
                },
              ),
            );
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                color: Colors.blue.shade900,
              ),
              new Positioned(
                top: size.height * 0.2,
                left: size.width / 40,
                child: ProfileWidget('helloword'),
              ),
              new Positioned(
                top: size.height * 0.30,
                left: size.width * 0.34,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.person,
                              size: 20.0,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          Text(
                            'Boxerbuzz',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: 'QuickSand',
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.email,
                              size: 20.0,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          Text(
                            'Boxerbuzz559@gmail.com',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'QuickSand',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.category,
                              size: 20.0,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            'Startup',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'QuickSand',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(String title, IconData iconData, VoidCallback action) {
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
                color: Colors.blue.shade900,
                borderRadius: new BorderRadius.circular(5.0),
              ),
              alignment: Alignment.center,
              child: new Icon(iconData, color: Colors.white, size: 24.0),
            ),
            new Text(title, style: textStyle),
            new Expanded(child: new Container()),
            new IconButton(
                icon: new Icon(Icons.chevron_right, color: Colors.black26),
                onPressed: action)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Profile",
          style: new TextStyle(
            fontFamily: 'QuickSand',
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1.0,
          ),
        ),
        leading: new CupertinoButton(
          child: new Icon(
            CupertinoIcons.left_chevron,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          Expanded(child: Container()),
          new CupertinoButton(
            child: new Icon(
              Icons.notifications_none,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new ProfileHeader(),
            new QuickActions(),
            Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                children: <Widget>[
                  _buildListItem("Edit Profile", Icons.edit, () {}),
                  _buildListItem("Favourites", Icons.favorite, () {}),
                  _buildListItem("About", Icons.info_outline, () {}),
                  _buildListItem('Log out', Icons.power_settings_new, () {
                    $AppAuthState(context).dispatch(isAutheticated.signOut);
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    const headerHeight = 120.0;
    final bloc = $AppAuthState(context);
    return StreamBuilder(
        stream: bloc.mapEventToState(isAutheticated.userData),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          UsersProfile user;
          if (!snapshot.hasData) {
            return Offstage();
          }

          if (snapshot.data == null ||
              snapshot.data.runtimeType != UsersProfile) {
            user = UsersProfile(
                firstName: '',
                lastName: '',
                city: '',
                followers: 0,
                following: 0,
                address: null,
                tel: null,
                likes: 0);
            return Offstage();
          }

          user = snapshot.data;

          /// TODO remove this code later
          user.followers = 0;
          user.following = 0;
          user.likes = 0;

          return new Container(
            height: headerHeight,
            decoration: new BoxDecoration(
              color: Colors.blue.shade900,
            ),
            child: new Stack(
              fit: StackFit.expand,
              children: <Widget>[
                new Container(
                  height: headerHeight,
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(colors: <Color>[
                      Colors.blue.shade900,
                      Colors.blue.shade700,
                    ], stops: <double>[
                      0.3,
                      0.5
                    ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                  ),
                ),
                new CustomPaint(
                  painter: new HeaderGradientPainter(),
                ),
                new Padding(
                  padding: new EdgeInsets.only(
                      top: topPadding, left: 15.0, right: 15.0, bottom: 20.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
                        child: _buildAvatar(user),
                      ),
                   //   _buildFollowerStats(user)
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildAvatar(UsersProfile user) {
    return new Row(
      children: <Widget>[
        new Container(
          width: 70.0,
          height: 60.0,
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new CachedNetworkImageProvider(user.passport == null
                    ? getDefaultImageUrl(user.email)
                    : user.passport),
                fit: BoxFit.cover),
            borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                  color: Colors.black26, blurRadius: 5.0, spreadRadius: 1.0),
            ],
          ),
        ),
        new Padding(padding: const EdgeInsets.only(right: 20.0)),
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('${user.lastName} ${user.firstName}',
                style: mainTextStyle),
            new Text(user.city != null ? user.city : '', style: subTextStyle),
          ],
        ),
      ],
    );
  }

  // Widget _buildFollowerStats(UsersProfile user) {
  //   return new Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: <Widget>[
  //       _buildFollowerStat("Followers", user.followers.toString()),
  //       _buildVerticalDivider(),
  //       _buildFollowerStat("Following", user.following.toString()),
  //       _buildVerticalDivider(),
  //       _buildFollowerStat("Total Likes", user.likes.toString()),
  //     ],
  //   );
  // }

  Widget _buildFollowerStat(String title, String value) {
    final titleStyle = new TextStyle(
        fontSize: 16.0, fontFamily: 'QuickSand', color: Colors.white);
    final valueStyle = new TextStyle(
        fontFamily: 'QuickSand',
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: Colors.white);
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(title, style: titleStyle),
        new Text(value, style: valueStyle),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return new Container(
      height: 30.0,
      width: 1.0,
      color: Colors.white30,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }
}

class QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
                                          return _startupItem(startup);
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
    backgroundImage =  startup.image[Random.secure().nextInt(3)];
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
            image: DecorationImage(image: CachedNetworkImageProvider(backgroundImage),fit: BoxFit.cover)),
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
