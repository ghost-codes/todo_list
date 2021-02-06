import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:todo_list/core/models/activity.dart';
import 'package:todo_list/core/sql_lite/databaseProvider.dart';
import 'package:uuid/uuid.dart';

class CreateToDoBloc {
  CreateToDoBloc() {
    getActivities();
  }
  var uuid = new Uuid();

  Activity tempActivity = Activity();
  final activityKey = GlobalKey<FormState>();

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
}
