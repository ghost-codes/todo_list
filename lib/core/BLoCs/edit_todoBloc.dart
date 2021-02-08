import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/core/models/todo.dart';
import 'package:todo_list/core/sql_lite/databaseProvider.dart';

class EditTodoBloc {
  ToDo tempTodo;
  EditTodoBloc(this.tempTodo);
  String min;
  String hour;

  final todoKey = GlobalKey<FormState>();

  //update Todo Object in DB
  editTodo(context) async {
    final form = todoKey.currentState;
    if (form.validate()) {
      form.save();
      await DBProvider.db.updateToDo(tempTodo);
      Navigator.pop(context);
    }
  }

  setTodoDescription(val) {
    tempTodo.description = val;
  }

  setTodoTitle(val) {
    tempTodo.title = val;
  }

  setTime(DateTime val) {
    tempTodo.datetime = DateFormat("HH:mm").format(val);
  }

  setTodoMin(val) {
    min = val;
  }

  setTodohour(val) {
    hour = val;
  }
}
