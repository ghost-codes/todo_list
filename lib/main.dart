import 'package:flutter/material.dart';
import 'package:todo_list/core/locator.dart';
import 'package:todo_list/core/util/appColors.dart';
import 'package:todo_list/ui/views/edit_todo.dart';
import 'package:todo_list/ui/views/exportViews.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: LColors.primaryColor,
      ),
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        if (settings.name == '/create_task_details') {
          return MaterialPageRoute(builder: (context) {
            return CreateToDoDetails(bloc: settings.arguments);
          });
        }
        if (settings.name == '/edit_task') {
          return MaterialPageRoute(builder: (context) {
            return EditTodoView.create(context, settings.arguments);
          });
        }
      },
      routes: {
        '/splash': (context) => SplashScreen(),
        '/': (context) => HomeView.create(context),
        '/create_task': (context) => CreateToDoView.create(context),
        // '/create_task_details': (context) => CreateToDoDetails.create(context,),
      },
    );
  }
}
