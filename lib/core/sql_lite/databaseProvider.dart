import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/core/models/todo.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "ToDoDB.db";
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Todo ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "description TEXT,"
          "datetime TEXT,"
          "duration TEXT,"
          "activity TEXT"
          "isDone BOOLEAN"
          ")");
    });
  }

  getAllToDos() async {
    final db = await database;
    var res = await db.query("Todo");
    List<ToDo> list =
        res.isNotEmpty ? res.map((c) => ToDo.fromJson(c)).toList() : [];
    return list;
  }
}
