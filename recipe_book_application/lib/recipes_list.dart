import 'package:flutter/material.dart';
import 'constants.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key, required this.title});
  final String title;


  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour,
      body: Center(
        child: ListView(children: [],),
      ),
    );
  }
}

class RecipeCard extends StatefulWidget {
  const RecipeCard({super.key, required this.title, required this.cookingTime, this.portions = 0});
  final String title;
  final DateTime cookingTime;
  final int portions;
  
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour,
      body: Center(
        child: ListView(children: [],),
      ),
    );
  }
}