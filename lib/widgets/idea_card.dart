import 'dart:math';

import 'package:eds_funds/import.dart';
import 'package:flutter/material.dart';
import 'package:eds_funds/utils/constants.dart';

class StartDetails extends StatelessWidget {
  String docId;
  StartDetails _startup;
  Startup(docId) {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.collection('startup').document(docId).get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> docSnapshot) {
        if (docSnapshot.hasData) {
          if (docSnapshot.data.exists) {
            return Card(
              child: Container(
                width: 230.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 3.0, horizontal: 8.0),
                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                            decoration: BoxDecoration(
                              gradient: new LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.blue.shade900,
                                  Colors.blue,
                                ],
                              ),
                            ),
                            child: Text(
                              docSnapshot.data.data['category'].toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9.0,
                                fontFamily: 'QuickSand',
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/verified.png',
                            width: 15.0,
                            height: 15.0,
                          )
                        ],
                      ),
                      Container(
                        height: 50.0,
                        child: Text(
                           docSnapshot.data.data['name'],
                          maxLines: 2,
                          style: TextStyle(
                            color: AppColors.boldText,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'QuickSand',
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                           docSnapshot.data.data['desc'],
                          textAlign: TextAlign.left,
                          maxLines: 5,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: AppColors.bodyText,
                            fontFamily: 'QuickSand',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage( docSnapshot.data.data['category'][Random.secure().nextInt(docSnapshot.data.data['category'].length)]),
                            ),
                          ),
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                        ),
                      ),
                      Divider(
                        height: 20.0,
                        color: AppColors.lightGrey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              text: "Don't know what to put here",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.0,
                                fontFamily: 'QuickSand',
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' VOTES',
                                  style: TextStyle(
                                    color: AppColors.bodyText,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.favorite_border,
                                size: 14.0,
                                color: AppColors.lightGrey,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10.0),
                              ),
                              Icon(
                                Icons.share,
                                size: 14.0,
                                color: AppColors.lightGrey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
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
