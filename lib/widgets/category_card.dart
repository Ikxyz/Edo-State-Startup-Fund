import 'package:eds_funds/utils/constants.dart';
import 'package:flutter/material.dart';
import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({
    Key key,
    @required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(milliseconds: 400),
      child: Container(
        margin: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0.0,
              offset: Offset(0.0, 10.0),
              blurRadius: 18.0,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Hero(
                tag: "${category.title}_bg",
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(category.image),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Material(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  category.title,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: AppColors.boldText,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'QuickSand',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            category.description,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 14.0,
                                color: AppColors.bodyText,
                                fontFamily: 'Raleway'),
                          ),
                        ],
                      ),
                    ),
                    FlatButton(
                      color: Colors.blue.shade900,
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "EXPLORE",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              letterSpacing: 1.4,
                              fontSize: 12.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'QuickSand',
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 12.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
