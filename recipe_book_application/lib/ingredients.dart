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
  late ListView _listView = _createEmptyList();

  bool _isNumeric(String s) {
    return double.tryParse(s) != null;
  }

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
                onSaved: (String? value) {
                  print(value);
                },
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
                  return (value != null && !_isNumeric(value))
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

  ListView _createEmptyList() {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      physics: const AlwaysScrollableScrollPhysics(),
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 16),
        ),
        Icon(
          Icons.search,
          color: Color.fromARGB(255, 119, 119, 119),
          size: 60,
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
        ),
        Text(
          'No ingredients yet.',
        )
      ],
    );
  }

  Future<void> _getIngredientData() async {
    try {
      _data = await DatabaseManager.retrieveIngredients();
    } on DatabaseException {
      _data = [];
    }
    _refreshListView();
  }

  Future<void> _refreshListView() async {
    if (_data.isEmpty) {
      _listView = _createEmptyList();
    }

    _listView = ListView.builder(
      itemCount: _data.length,
      itemBuilder: (BuildContext context, int index) {
        Ingredient ingredient = _data[index];
        return IngredientCard(ingredient: ingredient);
      },
      padding: const EdgeInsets.all(10),
      physics: const AlwaysScrollableScrollPhysics(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _getIngredientData();
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
      body: RefreshIndicator(
        child: _listView,
        onRefresh: _refreshListView,
      ),
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
              widget.ingredient.name,
            )),
            body: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Name:  ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(widget.ingredient.name,
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  Row(
                    children: [
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
