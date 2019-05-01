import 'package:eds_funds/classes/start_up.dart';
import 'package:eds_funds/data/data.dart';
 
import 'package:eds_funds/utils/constants.dart';

class Category {
  final String title;
  final String image;
  final String description;
  final List<StartupClass> startup;

  Category(
      {this.title,
      this.image,
      this.description,
      this.startup});

   List<Category> get generate=> [
      Category(
        title: "Edu-Tech",
        image: DestinationImages.one,
        description:
        "The study and ethical practice of facilitating learning and improving performance through appropriate technology.",
        startup:generateStartupData(),
      ),
      Category(
        title: "Fin-Tech",
        image: DestinationImages.two,
        description:
            "Technology and innovation that aims to compete with traditional financial methods in the delivery of financial services.",
        startup:generateStartupData(),
      ),
      Category(
        title: "Machine Learning",
        image: DestinationImages.three,
        description:
            "Intelligence demonstrated by machines, in contrast to the natural intelligence displayed by humans and other animals",
        startup:generateStartupData(),
      ),
      Category(
        title: "Med-Tech",
        image: DestinationImages.four,
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do et dolore magna aliqua. Ut enim ad minim veniam,",
        startup:generateStartupData(),
      ),
      Category(
        title: "E-Commerce",
        image: DestinationImages.five,
        description:
        "Electronic commerce is a way of doing business over large electronic networks such as the Internet.",
        startup:generateStartupData(),
      ),
      Category(
        title: "Virtual Reality",
        image: DestinationImages.six,
        description:
        "Virtual reality is an interactive computer-generated experience taking place within a simulated environment.",
        startup:generateStartupData(),
      ),
    ];
  
}
