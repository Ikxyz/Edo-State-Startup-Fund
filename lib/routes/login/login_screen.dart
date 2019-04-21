import 'package:flutter/material.dart';

class LoginRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var top = MediaQuery.of(context).size.height * 0.1;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Opacity(
            opacity: .2,
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: null,
            bottom: 32.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Edo Startup Fund',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comfortaa'),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "v" + '1.0.0',
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          Stack(
            children: <Widget>[
              Center(
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 148.0,
                  color: Colors.white30,
                  colorBlendMode: BlendMode.saturation,
                ),
              ),
              Positioned.fill(
                top: null,
                bottom: 124.0,
                child: Center(
                  child: RaisedButton.icon(
                    color: Colors.white,
                    onPressed: () {},
                    icon: Image(
                      image: AssetImage('assets/images/google.png'),
                      width: 24.0,
                    ),
                    label: Text(
                      "Continue with Google",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Comfortaa',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

}