import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  static const POSTER_RATIO = 0.7;

  ProfileWidget(
    this.url, {
    this.height = 100.0,
  });

  final String url;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: new Container(
        height: 150.0,
        width: 100.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cat6.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      onTap: () {

      },
    );
  }
}
