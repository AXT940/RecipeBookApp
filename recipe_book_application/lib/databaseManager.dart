import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseManager {
  late Database database;

  DatabaseManager(String name) {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
    }
    WidgetsFlutterBinding.ensureInitialized();
    databaseFactory = databaseFactoryFfi;
    _initDatabase();
  }

  void _initDatabase() async {
    final path = await getDatabasesPath();
    database = await openDatabase(join(path, 'RecipeBook_database.db'),
        onOpen: (db) {}, onCreate: (db, version) {
      db.execute(
          'create table Recipes(id INTEGER PRIMARY KEY, title TEXT NOT NULL, method BLOB NOT NULL, description TEXT, length INT)');
      db.execute(
          'create table Ingredients(id INTEGER PRIMARY, name TEXT NOT NULL, price NUMBER)');
    }, version: 1);
  }

  void __addRecipe() async {}
}
