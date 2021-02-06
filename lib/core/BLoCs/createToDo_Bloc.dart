import 'dart:async';

import 'package:todo_list/core/models/activity.dart';
import 'package:todo_list/core/sql_lite/databaseProvider.dart';

class CreateToDoBloc {
  CreateToDoBloc() {
    getActivities();
  }

  final StreamController<List<Activity>> _activityList =
      StreamController<List<Activity>>.broadcast();

  Stream<List<Activity>> get activityList => _activityList.stream;

  getActivities() async {
    _activityList.sink.add(await DBProvider.db.getAllActivites());
  }
}
