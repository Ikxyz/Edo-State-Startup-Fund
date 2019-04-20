import 'dart:math';

import 'package:eds_funds/models/user.dart';
import 'package:eds_funds/routes/startup/new_startup_screen.dart';
import 'package:eds_funds/widgets/profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = getProfile();

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
                              color: Colors.blue.shade900,
                            ),
                          ),
                          Text(
                            'Startup',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'QuickSand',
                              fontWeight: FontWeight.bold,
                            ),
                          )
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
            new ProfileHeader(user),
            new QuickActions(),
            Padding(
              padding: EdgeInsets.only( left: 8.0, right: 8.0),
              child: Column(
                children: <Widget>[
                  _buildListItem("Edit Profile", Icons.edit, () {}),
                  _buildListItem("Favourites", Icons.favorite, () {}),
                  _buildListItem("About", Icons.info_outline, () {}),
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
  final User user;

  ProfileHeader(this.user);

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    const headerHeight = 200.0;
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
                  child: _buildAvatar(),
                ),
                _buildFollowerStats()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
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

    return new Row(
      children: <Widget>[
        new Container(
          width: 70.0,
          height: 60.0,
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("assets/images/cat4.jpg"),
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
            new Text(user.fullName, style: mainTextStyle),
            new Text(user.location, style: subTextStyle),
          ],
        ),
      ],
    );
  }

  Widget _buildFollowerStats() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildFollowerStat("Followers", user.numberOfFollowersString),
        _buildVerticalDivider(),
        _buildFollowerStat("Following", user.numberFollowingString),
        _buildVerticalDivider(),
        _buildFollowerStat("Total Likes", user.totalLikesString),
      ],
    );
  }

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

    return new Container(
      constraints: const BoxConstraints(maxHeight: 120.0),
      margin: const EdgeInsets.only(top: 20.0),
      child: new Align(
        alignment: Alignment.center,
        child: new ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(
              left: 10.0, bottom: 20.0, right: 10.0, top: 10.0),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            _buildAction("Project\nEcommerce", () {}, Colors.blue, blueGradient,
                new AssetImage("assets/images/ic_ecommerce.png")),
            _buildAction("Project\nFintech", () {}, Colors.purple,
                purpleGradient, new AssetImage("assets/images/ic_fintech.png")),
            _buildAction("Project\nDesign", () {}, Colors.red, redGradient,
                new AssetImage("assets/images/ic_design.png")),
            _buildAction(
                "Project\nDelivery",
                () {},
                Colors.purple,
                purpleGradient,
                new AssetImage("assets/images/ic_delivery.png")),
            _buildAction(
                "Project\nDevelopment",
                () {},
                Colors.blue,
                blueGradient,
                new AssetImage("assets/images/ic_development.png")),
            _buildAction("Project\nInternet", () {}, Colors.red, redGradient,
                new AssetImage("assets/images/ic_internet.png")),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(String title, VoidCallback action, Color color,
      Gradient gradient, ImageProvider backgroundImage) {
    final textStyle = new TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 18.0,
        fontFamily: 'QuickSand');

    return new GestureDetector(
      onTap: action,
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
            gradient: gradient),
        child: new Stack(
          children: <Widget>[
            new Opacity(
              opacity: 0.2,
              child: new Align(
                alignment: Alignment.centerRight,
                child: new Transform.rotate(
                  angle: pi / 4.8,
                  alignment: Alignment.centerRight,
                  child: new ClipPath(
                    clipper: new _BackgroundImageClipper(),
                    child: new Container(
                      padding: const EdgeInsets.only(
                          bottom: 20.0, right: 0.0, left: 60.0),
                      child: new Image(
                        width: 90.0,
                        height: 90.0,
                        image: backgroundImage != null
                            ? backgroundImage
                            : new AssetImage("assets/images/ic_wearable.png"),
                      ),
                    ),
                  ),
                ),
              ),
            ), // END BACKGROUND IMAGE

            new Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: new Text(title, style: textStyle),
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
  void paint(Canvas canvas, Size size) {
    // TODO: paint background radial gradient
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
