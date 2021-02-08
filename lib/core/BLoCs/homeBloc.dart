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

  //setting date to filter ToDos
  setDate(DateTime dates) {
    date = dates;
    _date.sink.add(dates);
  }

  getTodos() async {
    _todoListController.sink.add(
        await DBProvider.db.getAllToDos(DateFormat("yyyy-MM-dd").format(date)));
  }

  //push to a named route with argumest then update view when Navigator stack is popped
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

//closing all streams
  dispose() {
    _todoListController.close();
    _date.close();
  }

  //delete specific task with respect to its id
  deleteWithId(String id, context) async {
    await DBProvider.db.deleteToDo(id);
    Navigator.of(context).pop();
    getTodos();
  }

//set task to done
  taskIsDone(ToDo todo) async {
    await DBProvider.db.updateToDo(todo);
    getTodos();
  }
}
