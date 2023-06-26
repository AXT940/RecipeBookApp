import 'package:flutter/material.dart';
import 'package:recipe_book_application/constants.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key, required this.title});
  final String title;

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour,
      body: Center(
        child: ListView(children: const [Text("Shopping List", style: TextStyle(fontSize: 24, color: Colors.black),)],),
      ),
    );
  }
}