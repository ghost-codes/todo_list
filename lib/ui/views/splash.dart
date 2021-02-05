import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/core/util/appColors.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(Duration(milliseconds: 3000), () {
      Navigator.pushReplacementNamed(context, '/');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LColors.white,
      child: Center(
          child: SpinKitChasingDots(
        color: LColors.primaryColor,
        size: 50,
      )),
    );
  }
}
