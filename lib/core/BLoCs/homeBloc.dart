import 'dart:async';

import 'package:todo_list/core/models/todo.dart';
import 'package:todo_list/core/sql_lite/databaseProvider.dart';

class HomeBloc {
  HomeBloc() {}

  final StreamController<List<ToDo>> _todoListController =
      StreamController<List<ToDo>>.broadcast();

  Stream<List<ToDo>> get todoList => _todoListController.stream;

  getTodos() async {
    _todoListController.sink.add(await DBProvider.db.getAllToDos());
  }
}
