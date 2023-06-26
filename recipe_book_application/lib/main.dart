import 'package:flutter/material.dart';
import 'package:recipe_book_application/constants.dart';

import 'package:recipe_book_application/recipes.dart';
import 'package:recipe_book_application/meal_plan.dart';
import 'package:recipe_book_application/shopping_list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; 

  static final List<Text> _titleOptions = <Text>[const Text("Your Recipes"), const Text("Meal Plan"), const Text("Shopping List")];
  static final List<Widget> _screenViewOptions = <Widget>[const RecipeList(title:"Your Recipes"), const MealPlan(title:"Meal Plan"), const ShoppingList(title: "Shopping List")];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColour,
        appBar: AppBar(backgroundColor: appBar, title: const Text("Homecook Recipe App", style: TextStyle(color:Color.fromARGB(255, 255, 255, 255)),),),
        body: _screenViewOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(items: [BottomNavigationBarItem(
            icon: const Icon(Icons.dining),
            label: 'Recipes',
            backgroundColor: recipesColour,
          ),
          BottomNavigationBarItem(icon: const Icon(Icons.shopping_basket), 
          label: "Basket",
          backgroundColor: shoppingListColour),
          BottomNavigationBarItem(icon: const Icon(Icons.calendar_view_month), 
          label: "Meal Plan",
          backgroundColor: mealPlanColour)],
          currentIndex: _selectedIndex,
        onTap: _onItemTapped,
          ),
      );
  }
}