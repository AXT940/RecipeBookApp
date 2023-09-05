import 'package:flutter/material.dart';

Color textColour = const Color.fromARGB(255, 0, 0, 0);
Color backgroundColour = const Color.fromARGB(255, 211, 211, 211);
Color appBar = const Color.fromARGB(255, 1, 80, 1);

Color recipesColour = const Color.fromARGB(255, 192, 16, 16);
Color shoppingListColour = const Color.fromARGB(255, 36, 11, 177);
Color mealPlanColour = const Color.fromARGB(255, 105, 0, 175);

Color bannerColour = const Color.fromARGB(255, 177, 124, 11);

Color discardButtonColour = const Color.fromARGB(255, 128, 128, 128);

class Recipe {
  static const String tableName = "Recipes";

  final String title;
  final String method;
  final String description;
  final int length;
  final int serves;

  const Recipe(
      {required this.title,
      required this.method,
      required this.length,
      required this.serves,
      this.description = ""});

  Recipe.fromMap(Map<String, dynamic> recipe)
      : title = recipe['title'],
        method = recipe['method'],
        description = recipe['description'],
        length = recipe['length'],
        serves = recipe['serves'];

  Map<String, Object> toMap() {
    return {
      'title': title,
      'method': method,
      'description': description,
      'length': length,
      'serves': serves
    };
  }
}

class Ingredient {
  final String name;
  final double price;

  static const String tableName = "Ingredients";

  const Ingredient({required this.name, this.price = 0.0});

  Ingredient.fromMap(Map<String, dynamic> ingredient)
      : name = ingredient['name'],
        price = ingredient['price'];

  Map<String, Object> toMap() {
    return {'name': name, 'price': price};
  }
}

class Category {
  final String type;

  static const String tableName = "Categories";

  const Category({required this.type});

  Category.fromMap(Map<String, dynamic> category) : type = category['type'];

  Map<String, Object> toMap() {
    return {'type': type};
  }
}

bool isNumeric(String s) {
    return double.tryParse(s) != null;
}
