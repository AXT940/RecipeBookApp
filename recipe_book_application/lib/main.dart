import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:recipe_book_application/type.dart';

import 'package:recipe_book_application/recipes.dart';
import 'package:recipe_book_application/meal_plan.dart';
import 'package:recipe_book_application/shopping_list.dart';

import 'package:recipe_book_application/ingredients.dart';

void main() async {
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
  }
  WidgetsFlutterBinding.ensureInitialized();
  databaseFactory = databaseFactoryFfi;

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

  static final List<Widget> _screenViewOptions = <Widget>[
    const RecipeList(title: "Your Recipes"),
    const ShoppingList(title: "Shopping List"),
    const MealPlan(title: "Meal Plan"),
    const IngredientList(title: "Ingredients"),
  ];

  static final List<Text> _screenTitles = <Text>[
    const Text("Recipes"),
    const Text("Basket"),
    const Text("Meal Plan")
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour,
      appBar: AppBar(
        backgroundColor: appBar,
        title: const Text(
          "Homecook Recipe App",
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: appBar),
              child: const Text("Homecook Recipe App",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  )),
            ),
            ListTile(
              title: _screenTitles.elementAt(0),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: _screenTitles.elementAt(1),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: _screenTitles.elementAt(2),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            const Divider(
              color: Color.fromARGB(255, 170, 169, 169),
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              title: const Text("Ingredients"),
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
            const ListTile(title: Text("Categories")),
          ],
        ),
      ),
      body: _screenViewOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dining),
            label: 'Recipes',
            backgroundColor: recipesColour,
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_basket),
              label: "Basket",
              backgroundColor: shoppingListColour),
          BottomNavigationBarItem(
              icon: const Icon(Icons.calendar_view_month),
              label: "Meal Plan",
              backgroundColor: mealPlanColour)
        ],
        currentIndex:
            (_selectedIndex > _screenTitles.length - 1) ? 0 : _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
