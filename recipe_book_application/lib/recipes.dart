import 'package:flutter/material.dart';
import 'package:recipe_book_application/constants.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key, required this.title});
  final String title;

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour,
      body: Center(
        child: ListView(children: const [Text("Recipes", style: TextStyle(fontSize: 24, color: Colors.black),)],),
      ),
      floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () => {}
      ),
    );
  }
}

class RecipeCard extends StatefulWidget {
  const RecipeCard({super.key, required this.title, required this.cookingTime, this.portions = 0});
  final String title;
  final DateTime cookingTime;
  final int portions;
  
  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour,
      body: Center(
        child: ListView(children: const [],),
      ),
    );
  }
}