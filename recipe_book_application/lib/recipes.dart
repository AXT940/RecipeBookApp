import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:recipe_book_application/type.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key, required this.title});
  final String title;

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  AlertDialog _addRecipeDialog() {
    return AlertDialog(
      title: const Text("Add Recipe",
          style: TextStyle(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Title:",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter the recipes title"),
                onSaved: (String? value) {
                  print(value);
                },
                validator: (String? value) {
                  return (value != null && value.contains('@'))
                      ? 'Do not use the @ char.'
                      : null;
                },
                maxLength: 20,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              const Text(
                "Description:",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Describe the recipe"),
                onSaved: (String? value) {
                  print(value);
                },
                validator: (String? value) {
                  return (value != null && value.contains('@'))
                      ? 'Do not use the @ char.'
                      : null;
                },
                maxLength: 50,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
              ),
            ],
          )),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 10),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context, 'Cancel'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour,
      body: Center(
        child: ListView(
          children: const [
            Text(
              "Recipes",
              style: TextStyle(fontSize: 24, color: Colors.black),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return _addRecipeDialog();
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
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: const [],
      ),
    );
  }
}
