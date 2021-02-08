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

  DateTime tempDate = DateTime.now();
  String duration = '';
  String hour = '00';
  String min = '00';
  final activityKey = GlobalKey<FormState>();
  final todoKey = GlobalKey<FormState>();
  String temprActivity = '';

  final StreamController<List<Activity>> _activityList =
      StreamController<List<Activity>>.broadcast();

  final StreamController<String> _tempActivity =
      StreamController<String>.broadcast();

  final StreamController<DateTime> _tempDate =
      StreamController<DateTime>.broadcast();

  Stream<String> get selectedActivity => _tempActivity.stream;
  Stream<DateTime> get temprDate => _tempDate.stream;

  Stream<List<Activity>> get activityList => _activityList.stream;

  settemDate(DateTime date) {
    print(date);
    tempDate = date;
    _tempDate.sink.add(date);
  }

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
    if (val == null) {
      hour = '00';
    } else {
      hour = val;
    }
  }

  setTodoMin(String val) {
    if (val == null) {
      min = '00';
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
      print(temprActivity);
      _tempTodo.activity = temprActivity;
      _tempTodo.isDone = 0;
      _tempTodo.duration = "${hour}:${min}";
      _tempTodo.date = DateFormat("yyyy-MM-dd").format(tempDate);
      await DBProvider.db.postNewTodo(_tempTodo);
      Navigator.of(context).popUntil((route) {
        return route.settings.name == '/';
      });
      print("Add");
    }
  }

  setActivity(String val) {
    _tempActivity.sink.add(val);
  }

  setDate(DateTime date) {
    tempDate = date;
  }
}
