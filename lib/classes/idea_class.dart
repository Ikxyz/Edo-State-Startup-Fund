import 'package:flutter/material.dart';

class Idea {
  final String title;
  final String desc;
  final String image;
  final String body;
  final String category;
  final int places;

  Idea(
      {this.title,
      this.desc,
      this.image,
      this.body,
      this.category,
      this.places});
  factory Idea.fromJson(Map<String, dynamic> map) {
    return Idea(
        title: map['title'],
        image: map['image'],
        body: map['body'],
        category: map['category'],
        desc: map['desc'],
        places: map['places']);
  }

  static Map<String, dynamic> fromClassObject(Idea idea) {
    return {
      'title':idea.title,
      'desc':idea.desc,
      'image':idea.image,
      'body':idea.body,
      'category':idea.category,
      'places':idea.places
    };
  }
}
