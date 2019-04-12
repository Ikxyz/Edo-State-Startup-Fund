import 'package:flutter/material.dart';

class TextHeader extends StatelessWidget {
  const TextHeader({
    Key key,
    @required this.title,
    this.trailing,
  }) : super(key: key);

  final String title;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100].withOpacity(.4),
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 16.0,
        right: 16.0,
      ),
      alignment: AlignmentDirectional.centerStart,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: TextStyle(fontFamily: 'QuickSand'),
          ),
          Text(
            trailing,
            style: TextStyle(
              fontFamily: 'QuickSand',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
