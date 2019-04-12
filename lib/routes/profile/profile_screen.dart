import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget sampleItem() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
            color: Colors.blue.shade900,
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Virtual Shops',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: 'QuickSand',
                ),
              ),
              Text(
                '\$1000',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w900,
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.style,
                        size: 60.0,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: MaterialButton(
                  onPressed: () {},
                  child: Text('View Project'),
                  color: Colors.red,
                  padding: EdgeInsets.all(8.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: CupertinoButton(
          child: Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          new Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Profile Picture
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Container(
                      height: 150.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: Colors.amber,
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 0.5,
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/images/idea4.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  //UserName
                  new Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/verified.png',
                        width: 20.0,
                        height: 20.0,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        'Timothy Boxerbuzz',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'QuickSand',
                        ),
                      ),
                    ],
                  ),
                  //Stats
                  /*new Row(
                    children: <Widget>[
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        '1M+ Likes',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      Icon(
                        Icons.work,
                        color: Colors.blue.shade900,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "5 Start-Up's",
                        style: TextStyle(
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      Icon(
                        CupertinoIcons.group_solid,
                        color: Colors.green,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "30 Collaborators",
                        style: TextStyle(
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ],
                  ),*/
                  SizedBox(height: 10.0),
                  Divider(
                    color: Colors.blue.shade900,
                    height: 1.0,
                    indent: 5.0,
                  ),
                  SizedBox(height: 30.0),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Start-Up's",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'QuickSand',
                          fontSize: 18.0,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          CupertinoIcons.forward,
                          color: Colors.blue.shade900,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        radius: 30.0,
                      )
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        sampleItem(),
                        sampleItem(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
