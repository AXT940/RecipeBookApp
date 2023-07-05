import 'package:flutter/material.dart';

Color textColour = const Color.fromARGB(255, 0, 0, 0);
Color backgroundColour = const Color.fromARGB(255, 211, 211, 211);
Color appBar = const Color.fromARGB(255, 1, 80, 1);

Color recipesColour = const Color.fromARGB(255, 192, 16, 16);
Color shoppingListColour = const Color.fromARGB(255, 36, 11, 177);
Color mealPlanColour = const Color.fromARGB(255, 105, 0, 175);

Color bannerColour = const Color.fromARGB(255, 177, 124, 11);

class Recipe {
  final int id;
  final String title;
  final String method;
  final String description;
  final int length;
  final int serves;

  const Recipe(
      {required this.id,
      required this.title,
      required this.method,
      required this.length,
      required this.serves,
      this.description = ""});

  Recipe.fromMap(Map<String, dynamic> recipe)
      : id = recipe['id'],
        title = recipe['title'],
        method = recipe['method'],
        description = recipe['description'],
        length = recipe['length'],
        serves = recipe['serves'];

  Map<String, Object> toMap() {
    return {
      'id': id,
      'title': title,
      'method': method,
      'description': description,
      'length': length,
      'serves': serves
    };
  }
}

class Ingredient {
  final int id;
  final String title;
  final String description;

  const Ingredient(
      {required this.id, required this.title, this.description = ""});
}
