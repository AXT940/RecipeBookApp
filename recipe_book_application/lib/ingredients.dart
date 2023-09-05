import 'package:flutter/material.dart';

import 'package:recipe_book_application/type.dart';
import 'package:recipe_book_application/database_manager.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class IngredientList extends StatefulWidget {
  const IngredientList({super.key, required this.title});
  final String title;

  @override
  State<IngredientList> createState() => _IngredientListState();
}

class _IngredientListState extends State<IngredientList> {
  final TextEditingController _nameInputController = TextEditingController();
  final TextEditingController _priceInputController = TextEditingController();

  List<Ingredient> _data = [];
  //late ListView _listView = _createEmptyList();

  AlertDialog _addIngredientDialog() {
    return AlertDialog(
      title: const Text("Add Ingredient",
          style: TextStyle(fontWeight: FontWeight.bold)),
      titlePadding: const EdgeInsets.only(left: 10, top: 10),
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
                    labelText: "Name of the ingredient"),
                validator: (String? value) {
                  return (value == null)
                      ? 'Enter a name for the ingredient'
                      : null;
                },
                textCapitalization: TextCapitalization.sentences,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              const Text(
                "Price:",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 5)),
              TextFormField(
                controller: _priceInputController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "How much does this cost?"),
                onSaved: (String? value) {
                  print(value);
                },
                validator: (String? value) {
                  return (value != null && !isNumeric(value))
                      ? 'Please enter a number'
                      : null;
                },
              ),
            ],
          )),
      actions: [
        MaterialButton(
          padding: const EdgeInsets.all(5),
          onPressed: () {
            _nameInputController.text = "";
            _priceInputController.text = "";
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
            Ingredient ingredient = Ingredient(
              name: _nameInputController.text,
              price: double.tryParse(_priceInputController.text) ?? 00.00,
            );
            await DatabaseManager.addIngredient(ingredient);
            _nameInputController.text = "";
            _priceInputController.text = "";
            Navigator.pop(context);
          },
          child: const Text(
            "Save",
            style: TextStyle(color: Color.fromARGB(255, 0, 93, 199)),
          ),
        )
      ],
      actionsPadding: const EdgeInsets.only(left: 5, bottom: 20, right: 10),
    );
  }

  Future<void> _getIngredientData() async {
    try {
      _data = await DatabaseManager.retrieveIngredients();
    } on DatabaseException catch (e) {
      _data = [];
      print("Database Exception ${e}");
    }
  }

  Future<void> _refreshState() async {
    setState(() {
      _getIngredientData();
    });
  }

  @override
  Widget build(BuildContext context) {
    _refreshState();
    return Scaffold(
      backgroundColor: backgroundColour,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Ingredients",
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        backgroundColor: backgroundColour,
      ),
      body: RefreshIndicator(onRefresh: _refreshState, child: Column(
        children: [Expanded(child: ListView.builder(itemCount: _data.length, itemBuilder: (context, index) => IngredientCard(ingredient: _data[index]),)),
        ],
      ),),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return _addIngredientDialog();
            }),
      ),
    );
  }
}

class IngredientCard extends StatefulWidget {
  const IngredientCard({super.key, required this.ingredient});
  final Ingredient ingredient;

  @override
  State<IngredientCard> createState() => _IngredientCardState();
}

class _IngredientCardState extends State<IngredientCard> {

  final TextEditingController _nameInputController = TextEditingController();
  final TextEditingController _priceInputController = TextEditingController();

  AlertDialog _editIngredient() {
    return AlertDialog(title: const Text("Edit ingredient", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
    titlePadding: const EdgeInsets.only(left: 10, top: 10),
    content: SingleChildScrollView(physics: const BouncingScrollPhysics(),
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
                    labelText: "Name of the ingredient"),
                textCapitalization: TextCapitalization.sentences,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              const Text(
                "Price:",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 5)),
              TextFormField(
                controller: _priceInputController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "How much does this cost?"),
                validator: (String? value) {
                  return (value != null && !isNumeric(value))
                      ? 'Please enter a number'
                      : null;
                },
              ),
            ],
          )),
          actions: [ MaterialButton(child: Text("Discard", style: TextStyle(color: discardButtonColour),), 
            onPressed: () {
              Navigator.pop(context);
            },),
            MaterialButton(child: const Text("Save", style: TextStyle(color: Color.fromARGB(255, 0, 93, 199)),), onPressed: () {Navigator.pop(context);},)],
          );
  }

  AlertDialog _deleteDialog() {
    return AlertDialog(title: const Text("Delete ingredient", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),), content: Text("Are you sure you want to delete ${widget.ingredient.name}?"),
    titlePadding: const EdgeInsets.only(left: 10, top: 10),
    actions: [ MaterialButton(child: Text("Cancel", style: TextStyle(color: discardButtonColour),), 
    onPressed: () {
      Navigator.pop(context);
    },),
    MaterialButton(child: const Text("Delete", style: TextStyle(color: Color.fromARGB(200, 255, 0, 0)),), onPressed: () {Navigator.pop(context);},)],);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(
        widget.ingredient.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("£${widget.ingredient.price}",
          style: const TextStyle(color: Color.fromARGB(255, 170, 169, 169))),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute<Widget>(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
                title: Text(
              widget.ingredient.name,),
              actions: [IconButton(onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return _deleteDialog();
            }), icon: const Icon(Icons.delete)), 
            IconButton(onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return _editIngredient();
            }), icon: const Icon(Icons.edit_sharp))],),
            body: Center(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      const Text(
                        "Name:  ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(widget.ingredient.name,
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      const Text(
                        "Price:  ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text("£${widget.ingredient.price}",
                          style: const TextStyle(fontSize: 16)),
                    ],
                  )
                ],
              ),
            ),
          );
        }));
      },
      tileColor: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }
}
