import 'package:flutter/material.dart';

class MESSAGE {
  String id, msg, type, status, to, from, canRead;
  dynamic time;

  MESSAGE(
      {@required this.id,
      @required this.msg,
      @required this.type,
      @required this.status,
      @required this.time,
      @required this.to,
      @required this.from});
  factory MESSAGE.object(Map map) {
    return MESSAGE(
        id: map['id'],
        msg: map['msg'],
        type: map['type'],
        status: map['status'],
        time: map['time'],
        from: map['from'],
        to: map['to']);
  }
}
