import 'package:eds_funds/classes/category.dart';
import 'package:eds_funds/routes/home/header.dart';
import 'package:eds_funds/routes/home/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:eds_funds/utils/constants.dart';

class ExploreTab extends StatefulWidget {
  @override
  ExploreTabState createState() {
    return new ExploreTabState();
  }
}

class ExploreTabState extends State<ExploreTab> with TickerProviderStateMixin {
  final _searchFocusNode = FocusNode();
  final List<Category> _categories = Category().generate;

  AnimationController controller;
  Animation<double> opacity;
  Animation<double> slideUp;
  Animation<double> scale;

  @override
  initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              controller.forward();
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
        ),
        reverseCurve: Interval(
          0.0,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    slideUp = Tween<double>(
      begin: 200.0,
      end: 40.0,
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
          curve: Cubic(1.0, .37, .15, .82),
        ),
      ),
    );
    scale = Tween<double>(
      begin: 40.0,
      end: double.infinity,
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
          curve: Cubic(1.0, .37, .15, .82),
        ),
      ),
    );

    super.initState();
    _searchFocusNode.addListener(() {});
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  Widget buildSearchBar() {
    return Hero(
      tag: "SearchBar",
      child: Material(
        child: Container(
          alignment: Alignment.center,
          height: 50.0,
          width: MediaQuery.of(context).size.width - 40.0,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          margin: EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
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
          child: Stack(
            fit: StackFit.expand,
            children: [
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  border: InputBorder.none,
                  filled: false,
                  fillColor: Colors.white,
                  errorText: null,
                  hintStyle:
                      TextStyle(color: AppColors.lightGrey, fontSize: 12.0),
                  errorStyle: TextStyle(),
                  hintText: 'What would you like to see?',
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    color: AppColors.bodyText,
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  color: Colors.transparent,
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/search");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
            ),
            child: Column(
              children: <Widget>[Header()],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                new Expanded(
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    controller: PageController(viewportFraction: 0.880),
                    itemCount: _categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "startup/$index");
                        },
                        child: CategoryCard(
                          category: _categories[index],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
