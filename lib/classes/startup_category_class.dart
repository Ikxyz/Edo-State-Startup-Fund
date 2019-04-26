import 'package:eds_funds/classes/idea_class.dart';

class Category {
  final String title, teamLeader, stage, status, desc;
  final String image;
  final int temperature;
  final List<Idea> ideas;
  final List<String> teamMembers;

  Category(
      {this.teamLeader,
      this.stage,
      this.status,
      this.teamMembers,
      this.title,
      this.image,
      this.desc,
      this.temperature,
      this.ideas});

  factory Category.fromJson(Map<String, dynamic> map) {
    return Category(
        ideas: map['ideas'],
        desc: map['desc'],
        image: map['map'],
        stage: map['stage'],
        status: map['status'],
        teamLeader: map['teamLeader'],
        teamMembers: map['teamMembers'],
        title: map['title'],
        temperature: map['temperature']);
  }

  static Map<String, dynamic> fromClassToJson(Category e) {
    return {
      e.teamLeader.toString(): e.teamLeader,
      e.stage.toString(): e.stage,
      e.status.toString(): e.status,
      e.teamMembers.toString(): e.teamLeader,
      e.title.toString(): e.title,
      e.image.toString(): e.image,
      e.desc.toString(): e.desc,
      e.temperature.toString(): e.temperature,
      e.ideas.toString(): e.ideas
    };
  }
}
