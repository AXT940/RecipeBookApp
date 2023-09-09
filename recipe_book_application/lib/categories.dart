import 'package:flutter/material.dart';

import 'package:recipe_book_application/type.dart';
import 'package:recipe_book_application/database_manager.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key, required this.title});
  final String title;

  @override
  State<CategoryList> createState() => CategoryListState();
}

class CategoryListState extends State<CategoryList> {
  final TextEditingController _nameInputController = TextEditingController();

  AlertDialog _addCategoryDialog() {
    return AlertDialog(title: const Text("Add new category"), titlePadding: const EdgeInsets.only(left: 10, top: 10),
      content: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Name:",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 5)),
              TextFormField(
                controller: _nameInputController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Title of the category"),
                validator: (String? value) {
                  return (value == null)
                      ? 'Enter a name for the category'
                      : null;
                },
                textCapitalization: TextCapitalization.sentences,
              ),],
          )),
      actions: [
        MaterialButton(
          padding: const EdgeInsets.all(5),
          onPressed: () {
            _nameInputController.text = "";
            Navigator.pop(context);
          },
          child: Text(
            "Discard",
            style: TextStyle(color: discardButtonColour),
          ),
        ),
        MaterialButton(
          padding: const EdgeInsets.all(5),
          onPressed: () async {
            Category category = Category(
              type: _nameInputController.text,
            );
            await DatabaseManager.addCategory(category);
            _nameInputController.text = "";
            Navigator.pop(context);
          },
          child: const Text(
            "Save",
            style: TextStyle(color: Color.fromARGB(255, 0, 93, 199)),
          ),
        )
      ],
      actionsPadding: const EdgeInsets.only(left: 5, bottom: 20, right: 10),);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour,
      appBar: AppBar(centerTitle: true,
      title: const Text("Categories", style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),),
            backgroundColor: backgroundColour,),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {}
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});
  final Category category;

  @override 
  Widget build(BuildContext context) {
    return Card(child: ListTile(title: Text(category.type, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),),
    subtitle: Row(children: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit_sharp)),
    IconButton(onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog();
            }), icon: const Icon(Icons.delete))],)
    ,),);
  }
}