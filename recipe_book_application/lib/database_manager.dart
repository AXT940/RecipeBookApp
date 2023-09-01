import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/widgets.dart';

import 'package:recipe_book_application/type.dart';

class DatabaseManager {
  DatabaseManager._();

  static Future<void> _initDatabase(Database database) async {
    database.execute(
        'CREATE TABLE IF NOT EXISTS ${Recipe.tableName}(id INTEGER PRIMARY KEY, title TEXT NOT NULL UNIQUE, method BLOB NOT NULL, description TEXT, length INT);');
    database.execute(
        'CREATE TABLE IF NOT EXISTS ${Ingredient.tableName}(id INTEGER PRIMARY KEY, name TEXT NOT NULL UNIQUE, price NUM);');
    database.execute(
        'CREATE TABLE IF NOT EXISTS ${Category.tableName}(id INTEGER PRIMARY KEY, type TEXT NOT NULL UNIQUE UNIQUE);');
    database.execute(
        'CREATE TABLE IF NOT EXISTS RecipeIngredients(id INTEGER PRIMARY KEY, recipe_id INTEGER NOT NULL, ingredients_id INTEGER NOT NULL, FOREIGN KEY(recipe_id) REFERENCES Recipes(id), FOREIGN KEY(ingredients_id) REFERENCES Ingredients(id));');
    database.execute(
        'CREATE TABLE IF NOT EXISTS RecipeCategories(id INTEGER PRIMARY KEY, recipe_id INTEGER NOT NULL, categories_id INTEGER NOT NULL, FOREIGN KEY(recipe_id) REFERENCES Recipes(id), FOREIGN KEY(categories_id) REFERENCES Categories(id));');
  }

  static Future<Database> _openDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    final path = await getDatabasesPath();
    return openDatabase(join(path, 'RecipeBook_database.db'), onOpen: (db) {},
        onCreate: (db, version) async {
      await _initDatabase(db);
    }, version: 1);
  }

  //Recipes
  static Future<void> addRecipe(Recipe object) async {
    final database = await _openDB();
    await database.insert(Recipe.tableName, object.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Recipe>> retrieveRecipes() async {
    final database = await _openDB();
    final List<Map<String, dynamic>> records =
        await database.query(Recipe.tableName);
    return List.generate(records.length, (index) {
      return Recipe(
          title: records[index]['title'],
          method: records[index]['method'],
          description: records[index]['description'],
          length: records[index]['length'],
          serves: records[index]['serves']);
    });
  }

  //Ingredients
  static Future<void> addIngredient(Ingredient object) async {
    final database = await _openDB();
    await database.insert(Ingredient.tableName, object.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Ingredient>> retrieveIngredients() async {
    final database = await _openDB();
    final List<Map<String, dynamic>> records =
        await database.query(Ingredient.tableName);
    return List.generate(records.length, (index) {
      print(
          "Name ${records[index]['name']} Price ${records[index]['price']} Price Type ${records[index]['price'].runtimeType}");
      double value = 0;
      if (records[index]['price'].runtimeType == int) {
        value = 0.0;
      } else {
        value = records[index]['price'];
      }
      return Ingredient(name: records[index]['name'], price: value);
    });
  }

  //Categories
  static Future<void> addCategory(Category object) async {
    final database = await _openDB();
    await database.insert(Category.tableName, object.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Category>> retrieveCategories() async {
    final database = await _openDB();
    final List<Map<String, dynamic>> records =
        await database.query(Category.tableName);
    return List.generate(records.length, (index) {
      return Category(type: records[index]['type']);
    });
  }
}
