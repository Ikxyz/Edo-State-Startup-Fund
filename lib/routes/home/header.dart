import 'package:cached_network_image/cached_network_image.dart';
import 'package:eds_funds/classes/user_profile_class.dart';
import 'package:eds_funds/routes/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:eds_funds/models/app.dart';
import 'package:eds_funds/trigger/event.dart';
import 'package:eds_funds/classes/classes.dart';

class Header extends StatefulWidget {
  Header({Key key}) : super(key: key);

  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: $AppAuthState(context).mapEventToState(isAutheticated.userData),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final state = snapshot.data;
        UsersProfile e;
        if (state == null || state.runtimeType != UsersProfile) {
          return Offstage();
        }

        e = state;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10.0),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Edo Startup Fund',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'QuickSand',
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        e.lastName,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'QuickSand',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 10.0),
              child: InkWell(
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.blue,
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(getDefaultImageUrl(e.email)))),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ProfileScreen();
                      },
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
