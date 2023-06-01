import 'package:flutter/material.dart';
import 'package:recipe_book_application/constants.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColour,
        appBar: AppBar(backgroundColor: appBar, title: const Text("Homecook Recipe App", style: TextStyle(color:Color.fromARGB(255, 255, 255, 255)),),),
        drawer: Drawer(child:Center(
              child:ListView(children: [
                  
                  Card(child: ElevatedButton(onPressed: () {}, style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(recipesColour)), child: const Text("Recipes", style: TextStyle(color:Colors.white,),)),), 
                  Card(child:ElevatedButton(onPressed: () {},  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(shoppingListColour)), child: const Text("Shopping List", style: TextStyle(color:Colors.white,), ),)), 
                  Card(child: ElevatedButton(onPressed: () {}, style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(mealPlanColour)), child: const Text("Meal Plan", style:TextStyle(color:Colors.white,),)))],
              ),
        )),
        body: const Center(
          child: Text("Hello World."),
        ),
      );
  }
}