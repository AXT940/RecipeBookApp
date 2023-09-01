import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_book_application/type.dart';

class RecipeFormScreen extends StatefulWidget {
  const RecipeFormScreen({super.key});

  @override
  State<RecipeFormScreen> createState() => _AddRecipeFormState();
}

class _AddRecipeFormState extends State<RecipeFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Recipe",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: appBar,
        ),
        body: Form(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
            ],
          ),
        )));
  }
}
