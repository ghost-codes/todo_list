import 'package:flutter/material.dart';
import 'package:todo_list/core/util/appColors.dart';
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
      routes: {
        '/splash': (context) => SplashScreen(),
        '/': (context) => HomeView(),
        '/create_task': (context) => CreateToDoView(),
        '/create_task_details': (context) => CreateToDoDetails(),
      },
    );
  }
}
