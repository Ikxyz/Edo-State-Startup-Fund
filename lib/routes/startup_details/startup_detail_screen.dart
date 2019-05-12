import 'package:eds_funds/data/data.dart';
import 'package:eds_funds/import.dart';
import 'package:eds_funds/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartupDetailScreen extends StatefulWidget {
  String documentID;
  StartupDetailScreen(this.documentID);

  @override
  _StartupDetailScreenState createState() => _StartupDetailScreenState();
}

class _StartupDetailScreenState extends State<StartupDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: buildAppBar(context),
          body: FutureBuilder(
            future: db
                .collection('startup')
                .document(widget.documentID.toString().trim()).get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> docSnapshot) {
            
              return asyncWhileWaiting(
                docSnapshot,
                !docSnapshot.hasData
                    ? Offstage()
                    : Stack(
                        children: <Widget>[
                          Container(
                            child: SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.all(30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.only(top: 40.0),
                                      child: Text(
                                        docSnapshot.data.data['name'],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: AppColors.boldText,
                                          fontSize: 33.0,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'QuickSand',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10.0),
                                      child: Text(
                                      docSnapshot.data.data['desc'],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          height: 1.3,
                                          color: AppColors.darkGrey,
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 1.0,
                                          fontFamily: 'Raleway',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 220.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(docSnapshot
                                              .data.data['image'][0])
                                        ),
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10.0),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10.0),
                                      child: Text(
                                        docSnapshot.data.data['desc'],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          height: 1.3,
                                          color: AppColors.darkGrey,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Raleway',
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              );
            },
          )),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      leading: CupertinoButton(
          child: Icon(
            CupertinoIcons.back,
            color: AppColors.darkGrey,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
      actions: <Widget>[
        CupertinoButton(
          child: Icon(
            Icons.favorite_border,
            size: 22.0,
            color: AppColors.darkGrey,
          ),
          onPressed: () {},
        ),
        CupertinoButton(
          child: Icon(
            Icons.trending_up,
            size: 22.0,
            color: AppColors.darkGrey,
          ),
          onPressed: () {},
        ),
      ],
      elevation: 0.0,
      backgroundColor: Colors.transparent,
    );
  }
}
