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
}
