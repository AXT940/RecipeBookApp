import 'package:flutter/material.dart';
import 'package:recipe_book_application/type.dart';

class MealPlan extends StatefulWidget {
  const MealPlan({super.key, required this.title, req});
  final String title;
  

  @override
  State<MealPlan> createState() => _MealPlanState();
}

class _MealPlanState extends State<MealPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour,
      body: Center(
        child: ListView(children: const [Text("Meal Plan", style: TextStyle(fontSize: 24, color: Colors.black),)],),
      ),
    );
  }
}