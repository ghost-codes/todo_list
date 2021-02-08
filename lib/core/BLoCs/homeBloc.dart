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

  final StreamController<DateTime> _date =
      StreamController<DateTime>.broadcast();

  Stream<DateTime> get dateT => _date.stream;
  Stream<List<ToDo>> get todoList => _todoListController.stream;

  setDate(DateTime dates) {
    date = dates;
    _date.sink.add(dates);
  }

  getTodos() async {
    _todoListController.sink.add(
        await DBProvider.db.getAllToDos(DateFormat("yyyy-MM-dd").format(date)));
  }

  push(context, String name, [dynamic args]) async {
    if (args == null) {
      Navigator.of(context).pushNamed(name).then((value) async {
        getTodos();
      });
    } else {
      Navigator.of(context)
          .pushNamed(name, arguments: args)
          .then((value) async {
        getTodos();
      });
    }
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
