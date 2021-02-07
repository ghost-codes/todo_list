import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/core/models/activity.dart';
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
          "id TEXT PRIMARY KEY,"
          "title TEXT,"
          "description TEXT,"
          "datetime TEXT,"
          "duration TEXT,"
          "activity TEXT,"
          "isDone INTEGER"
          ");");
    });
  }

  getAllToDos() async {
    final db = await database;
    var res = await db.query("Todo");
    List<ToDo> list =
        res.isNotEmpty ? res.map((c) => ToDo.fromJson(c)).toList() : [];
    return list;
  }

  getAllActivites() async {
    final db = await database;
    await db.execute("CREATE TABLE IF NOT EXISTS Activity ("
        "id TEXT PRIMARY KEY,"
        "name TEXT,"
        "description TEXT"
        ");");
    var res = await db.query("Activity");
    List<Activity> list =
        res.isNotEmpty ? res.map((c) => Activity.fromJson(c)).toList() : [];
    return list;
  }

  postNewActivity(Activity activity) async {
    final db = await database;
    var res = await db.insert("Activity", activity.toJson());
    return res;
  }

  postNewTodo(ToDo todo) async {
    final db = await database;
    var res = await db.insert("Todo", todo.toJson());
    return res;
  }

  deleteToDo(String id) async {
    final db = await database;
    db.delete("Todo", where: "id = ?", whereArgs: [id]);
  }

  updateToDo(ToDo todo) async {
    final db = await database;
    var res = await db
        .update("ToDO", todo.toJson(), where: "id = ?", whereArgs: [todo.id]);
    return res;
  }
}
