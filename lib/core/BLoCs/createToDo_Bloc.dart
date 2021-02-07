import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/BLoCs/homeBloc.dart';
import 'package:todo_list/core/locator.dart';
import 'package:todo_list/core/models/activity.dart';
import 'package:todo_list/core/models/todo.dart';
import 'package:todo_list/core/sql_lite/databaseProvider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class CreateToDoBloc {
  final homeBloc = sl<HomeBloc>();
  CreateToDoBloc() {
    getActivities();
  }
  var uuid = new Uuid();

  Activity tempActivity = Activity();
  ToDo _tempTodo = ToDo();

  String duration = '';
  String hour = '';
  String min = '';
  final activityKey = GlobalKey<FormState>();
  final todoKey = GlobalKey<FormState>();

  final StreamController<List<Activity>> _activityList =
      StreamController<List<Activity>>.broadcast();

  Stream<List<Activity>> get activityList => _activityList.stream;

  getActivities() async {
    _activityList.sink.add(await DBProvider.db.getAllActivites());
  }

  activityName(String val) {
    tempActivity.name = val;
  }

  activityDescription(String val) {
    tempActivity.description = val;
  }

  dispose() {
    _activityList.close();
  }

  createActivity(context) async {
    var form = activityKey.currentState;
    if (form.validate()) {
      form.save();
      tempActivity.id = uuid.v1();
      await DBProvider.db.postNewActivity(tempActivity);
      Navigator.of(context).pop();
    }
    getActivities();
  }

  setTodoTitle(val) {
    _tempTodo.title = val;
  }

  setTodoDescription(val) {
    _tempTodo.description = val;
  }

  setTodohour(String val) {
    if (val != null) {
      hour = '';
    } else {
      hour = val;
    }
  }

  setTodoMin(String val) {
    if (val != null) {
      min = '';
    } else {
      min = val;
    }
  }

  setTime(DateTime val) {
    final f = DateFormat("hh:mm");
    _tempTodo.datetime = f.format(val);
  }

  createTodo(context) async {
    final form = todoKey.currentState;
    if (form.validate()) {
      form.save();
      _tempTodo.id = uuid.v1();
      _tempTodo.activity = await _tempActivity.stream.last;
      _tempTodo.isDone = 0;
      _tempTodo.duration = "${hour}h:${min}n";
      await DBProvider.db.postNewTodo(_tempTodo);
      Navigator.of(context).popUntil((route) {
        return route.settings.name == '/';
      });
    }
  }

  final StreamController<String> _tempActivity =
      StreamController<String>.broadcast();

  Stream<String> get selectedActivity => _tempActivity.stream;

  setActivity(String val) {
    _tempActivity.sink.add(val);
  }
}
