import 'package:eds_funds/routes/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:eds_funds/routes/home/expolore_tab.dart';
import 'package:eds_funds/classes/classes.dart';
import 'package:eds_funds/classes/auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _state = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user) {
      print(user);
     
     if(user==null)return Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route)=>false);
     });

    super.initState();
  }

   

  Widget build(BuildContext ctx) {
   
   // FirebaseAuth.instance.signOut();
    return Scaffold(
      key: _state,
      body: ExploreTab(),
    );
  }
}
