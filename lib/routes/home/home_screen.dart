import 'package:eds_funds/routes/ideas/new_idea_screen.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return NewIdeaScreen();
              },
            ),
          );
        },
        child: Icon(
          Icons.add_to_photos,
        ),
      ),
    );
  }
}
