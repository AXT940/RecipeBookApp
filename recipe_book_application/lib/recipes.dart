import 'package:flutter/material.dart';
import 'package:recipe_book_application/type.dart';

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
        onPressed: () => showDialog<String>(context: context, builder: (BuildContext context) {
          return AlertDialog(title: const Text("Add Recipe", style:TextStyle(fontWeight: FontWeight.bold)),
            content: const Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Adding new recipe")],),
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: const EdgeInsets.only(bottom: 10), 
            actions: [TextButton(child:const Text("Cancel"),
                      onPressed: () => Navigator.pop(context, 'Cancel'),
            ),],);
        }),
    ),
    );
  }
}

class RecipeCard extends StatefulWidget {
  const RecipeCard({super.key, required this.recipe});
  final Recipe recipe;
  
  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView(physics: const BouncingScrollPhysics(), children: [],),
    );
  }
}