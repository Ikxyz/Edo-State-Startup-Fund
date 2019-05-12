import 'package:eds_funds/import.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eds_funds/utils/constants.dart';

class StartupCard extends StatelessWidget {
  StartupClass _startup;
  StartupCard(this._startup);

  @override
  Widget build(BuildContext context) {
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
                    padding:
                        EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
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
                      'SeedFund',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.0,
                        fontFamily: 'QuickSand',
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_up,
                    color: Colors.red,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.green,
                  ),
                  Expanded(child: Container()),
                  CachedNetworkImage(
                    width: 15.0,
                    height: 15.0,
                    imageUrl: _startup.image[0],
                  )
                ],
              ),
              Container(
                height: 50.0,
                child: Text(
                  _startup.name,
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
                  _startup.category,
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
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider( _startup.image[0],),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
