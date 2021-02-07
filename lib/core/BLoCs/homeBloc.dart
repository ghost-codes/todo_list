import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/core/models/todo.dart';
import 'package:todo_list/core/sql_lite/databaseProvider.dart';

class HomeBloc {
  HomeBloc() {
    getTodos();
  }

  DateTime date = DateTime.now();

  final StreamController<List<ToDo>> _todoListController =
      StreamController<List<ToDo>>.broadcast();

  Stream<List<ToDo>> get todoList => _todoListController.stream;

  getTodos() async {
    _todoListController.sink.add(
        await DBProvider.db.getAllToDos(DateFormat("yyyy-MM-dd").format(date)));
  }

  push(context) async {
    Navigator.of(context).pushNamed('/create_task').then((value) async {
      getTodos();
    });
  }

  dispose() {
    _todoListController.close();
  }

  deleteWithId(String id, context) async {
    await DBProvider.db.deleteToDo(id);
    Navigator.of(context).pop();
    getTodos();
  }

  taskIsDone(ToDo todo) async {
    await DBProvider.db.updateToDo(todo);
    getTodos();
  }
}
