import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:eds_funds/import.dart';
import 'package:eds_funds/widgets/idea_card.dart';

class CategoryScreen extends StatefulWidget {
  int id;
  Category destination;
  CategoryScreen(id) {
    destination = Category().generate[id];
  }

  @override
  CategoryDetailScreenState createState() {
    return new CategoryDetailScreenState();
  }
}

class CategoryDetailScreenState extends State<CategoryScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> opacity;
  Animation<double> slideUp;
  Animation<double> appear;

  final StreamController<bool> _isAnimating = new StreamController.broadcast();
  Stream<bool> get isAnimating => _isAnimating.stream;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700))
          ..addStatusListener((status) {
            if (status == AnimationStatus.forward ||
                status == AnimationStatus.reverse) {
              _isAnimating.sink.add(true);
            } else if (status == AnimationStatus.completed ||
                status == AnimationStatus.dismissed) {
              _isAnimating.sink.add(false);
            }
          });

    opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        ),
        reverseCurve: Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        ),
      ),
    );

    slideUp = Tween<double>(
      begin: 200.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          1.0,
          curve: Cubic(1.0, .37, .15, .82),
        ),
        reverseCurve: Interval(
          0.0,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );

    appear = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.3,
          0.31,
          curve: Cubic(.06, 1.21, .26, .68),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _isAnimating.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return Material(
      child: Hero(
        tag: "${widget.destination.title}_bg",
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.grey.withOpacity(.8),
                BlendMode.multiply,
              ),
              fit: BoxFit.cover,
              image: AssetImage(widget.destination.image),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: StreamBuilder(
                stream: isAnimating,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return IconButton(
                    icon: Icon(Icons.close),
                    color: Colors.white,
                    onPressed: () {
                      if (!snapshot.hasData) return null;
                      if (!snapshot.data) {
                        controller.reverse();
                        Future.delayed(Duration(milliseconds: 300), () {
                          Navigator.pop(context);
                        });
                      }
                    },
                  );
                },
              ),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: buildSummary()),
                AnimatedBuilder(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "DISCOVER IDEAS",
                              style: TextStyle(
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'QuickSand',
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                            FlatButton(
                              onPressed: () {},
                              color: Colors.blue.shade900,
                              child: Text(
                                'SEE ALL',
                                style: TextStyle(
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'QuickSand',
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnimatedBuilder(
                        animation: appear,
                        builder: (BuildContext context, Widget child) {
                          return SizedBox.fromSize(
                            size: Size.fromHeight(
                              appear.value *
                                  MediaQuery.of(context).size.height /
                                  1.8,
                            ),
                            child: buildListView(),
                          );
                        },
                      ),
                    ],
                  ),
                  animation: opacity,
                  builder: (BuildContext context, Widget child) {
                    return Opacity(
                      opacity: opacity.value,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, slideUp.value),
                        child: child,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildListView() {
    return StreamBuilder(
      stream: db
          .collection('startup')
          .where('category', isEqualTo: widget.destination.title)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapShot) {
        asyncWhileWaiting(
            snapShot,
            snapShot.hasData
                ? ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 16.0),
                    // controller: ScrollController(initialScrollOffset: 20.0),
                    children: snapShot.data.documentChanges.map((docSnapshot) {
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(context,
                            "ideas/${docSnapshot.document.documentID}"),
                        child: Container(
                          height: 400.0,
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 20.0),
                          child: StartDetails(),
                        ),
                      );
                    }).toList(),
                  )
                : Offstage());
      },
    );
  }

  Widget buildSummary() {
    return AnimatedBuilder(
      animation: opacity,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: opacity.value,
          child: Transform(
            transform: Matrix4.identity()..translate(0.0, slideUp.value + 40),
            child: child,
          ),
        );
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        widget.destination.title,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'QuickSand',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                widget.destination.description,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontFamily: 'QuickSand',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
