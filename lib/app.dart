import 'package:eds_funds/routes/startup/startup_screen.dart';
import 'package:eds_funds/routes/home/home_screen.dart';
import 'package:eds_funds/routes/details/startup_detail_screen.dart';
import 'package:eds_funds/widgets/route_animations.dart';
import "package:flutter/material.dart";
import 'package:eds_funds/routes/search/search_screen.dart';

class EDSFunds extends StatelessWidget {
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name.contains("startup")) {
          final categoryId =
          int.parse(settings.name.replaceAll("startup", ""));
          return FadeInRoute(builder: (context) {
            return StartupScreen(categoryId);
          });
        }
        if (settings.name.contains("ideas")) {
          final int ideaId =
          int.parse(settings.name.replaceAll("ideas", ""));
          return SlideLeftRoute(builder: (context) {
            return StartupDetailScreen(id: ideaId,);
          });
        }
        switch (settings.name) {
          case "/":
            {
              return MaterialPageRoute(builder: (context) {
                return HomeScreen();
              });
            }
            break;
          case "/search":
            {
              return FadeInRoute(builder: (context) {
                return SearchScreen();
              });
            }
        }
      },
    );
  }
}

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: Colors.blue.shade900,
    primaryColor: Colors.blue.shade900,
    //buttonColor: Colors.brown.shade900,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    textSelectionColor: Colors.amber,
    errorColor: Colors.red,
    buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
    //primaryIconTheme: base.iconTheme.copyWith(color: Colors.brown.shade900),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
    bottomAppBarColor: Colors.white,
  );
}

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: Colors.grey);
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
    headline: base.headline.copyWith(
      fontWeight: FontWeight.w500,
      fontFamily: 'QuickSand',
    ),
    title: base.title.copyWith(fontSize: 18.0),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      fontFamily: 'QuickSand',
    ),
    body2: base.body2.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
      fontFamily: 'Raleway',
    ),
    button: base.button.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
      fontFamily: 'Raleway',
    ),
  )
      .apply(
    fontFamily: 'QuicksSand',
    //displayColor: Colors.brown.shade900,
    //bodyColor: Colors.brown.shade900,
  );
}