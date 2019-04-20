import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:eds_funds/routes/home/expolore_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  Widget build(BuildContext ctx) {
    return Scaffold(
      body: ExploreTab(),
    );
  }
}
