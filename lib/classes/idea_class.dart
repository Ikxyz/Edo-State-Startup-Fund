import 'package:flutter/material.dart';

class Idea {
  final String title;
  final String excerpt;
  final String image;
  final String body;
  final String category;
  final int places;

  Idea(
      {this.title,
      this.excerpt,
      this.image,
      this.body,
      this.category,
      this.places});
  factory Idea.object(Map<String, dynamic> map) {
    return Idea(
        title: map['title'],
        image: map['image'],
        body: map['body'],
        category: map['category'],
        excerpt: map['excerpt'],
        places: map['places']);
  }
}
