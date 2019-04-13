import 'package:eds_funds/classes/idea_class.dart';
import 'package:flutter/material.dart';

class Category {
  final String title;
  final String image;
  final String description;
  final int temperature;
  final List<Idea> ideas;

  Category(
      {this.title, this.image, this.description, this.temperature, this.ideas});
}
