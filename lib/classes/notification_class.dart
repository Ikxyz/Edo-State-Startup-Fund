

class NOTIFICATION {
  String title, desc, type;
  bool status;
  dynamic time;

  NOTIFICATION({this.title, this.desc, this.type, this.status, this.time});

  factory NOTIFICATION.object(Map map) {
    if (map == null) return null;
    return NOTIFICATION(
      type: map['type'],
      time: map['time'],
      status: map['status'],
      title: map['title'],
      desc: map['desc'],
    );
  }
}
