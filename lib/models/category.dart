import 'package:eds_funds/models/idea.dart';
import 'package:eds_funds/utils/constants.dart';

class Category {
  final String title;
  final String image;
  final String description;
  final List<Idea> ideas;

  Category(
      {this.title,
      this.image,
      this.description,
      this.ideas});

  static List<Category> generate() {
    return [
      Category(
        title: "Edu-Tech",
        image: DestinationImages.one,
        description:
        "The study and ethical practice of facilitating learning and improving performance through appropriate technology.",
        ideas:Idea.generate(),
      ),
      Category(
        title: "Fin-Tech",
        image: DestinationImages.two,
        description:
            "Technology and innovation that aims to compete with traditional financial methods in the delivery of financial services.",
        ideas:Idea.generate(),
      ),
      Category(
        title: "Machine Learning",
        image: DestinationImages.three,
        description:
            "Intelligence demonstrated by machines, in contrast to the natural intelligence displayed by humans and other animals",
        ideas:Idea.generate(),
      ),
      Category(
        title: "Med-Tech",
        image: DestinationImages.four,
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do et dolore magna aliqua. Ut enim ad minim veniam,",
        ideas:Idea.generate(),
      ),
      Category(
        title: "E-Commerce",
        image: DestinationImages.five,
        description:
        "Electronic commerce is a way of doing business over large electronic networks such as the Internet.",
        ideas:Idea.generate(),
      ),
      Category(
        title: "Virtual Reality",
        image: DestinationImages.six,
        description:
        "Virtual reality is an interactive computer-generated experience taking place within a simulated environment.",
        ideas:Idea.generate(),
      ),
    ];
  }
}
