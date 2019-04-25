import 'package:eds_funds/classes/idea_class.dart';
import 'package:flutter/material.dart';

class Startup {
    String name, teamLeader, stage, status, desc,category,hash;
    List<String> image;
    double fundRaised, softCap, hardCap;
    int temperature;
    List<Idea> ideas;
    List<String> teamMembers;

  Startup(
      {this.teamLeader,
      this.stage,this.category,
      this.status,
      this.fundRaised,
      this.softCap,
      this.hardCap,
      this.teamMembers,
      this.name,
      this.image,
      this.desc,
      this.hash,
      this.temperature,
      this.ideas});

  factory Startup.fromJson(Map<String, dynamic> map) {
    return Startup(
        ideas: map['ideas'],
        desc: map['desc'],
        image: map['map'],
        stage: map['stage'],
        status: map['status'],
        teamLeader: map['teamLeader'],
        teamMembers: map['teamMembers'],
        name: map['name'],
        fundRaised: map['fundRaised'],
        softCap: map['softCap'],
        hardCap: map['hardCap'],
        hash: map['hash'],
        category:map['category'],
        temperature: map['temperature']);
  }

  static Map<String, dynamic> fromClassToJson(Startup e) {
    return {
      'teamLeader': e.teamLeader,
      'stage': e.stage,
      'status': e.status,
      'teamMembers': e.teamLeader,
      'name': e.name,
      'image': e.image,
      'desc': e.desc,
      'fundRaised': e.fundRaised,
      'temperature': e.temperature,
      'ideas': e.ideas,
      'category': e.category
    };
  }
}
