import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:todo_list/core/util/appColors.dart';
import 'package:todo_list/core/util/inputDecorations.dart';
import 'package:todo_list/core/util/textThemes.dart';

class CreateToDoDetails extends StatefulWidget {
  @override
  _CreateToDoDetailsState createState() => _CreateToDoDetailsState();
}

class _CreateToDoDetailsState extends State<CreateToDoDetails> {
  TimeOfDay value = TimeOfDay(hour: 00, minute: 30);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LColors.white,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: LColors.black,
          ),
        ),
        title: Text(
          "Task Details",
          style: LTextThemes.bigTitleBlack,
        ),
      ),
      body: Container(
        color: LColors.white,
        child: Form(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            children: [
              Text(
                "Title",
                style: LTextThemes.mediumTitleBlack,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecorations.primary("title..."),
              ),
              SizedBox(height: 20),
              Text(
                "Time",
                style: LTextThemes.mediumTitleBlack,
              ),
              TimePickerSpinner(
                is24HourMode: false,
                itemHeight: 30,
                normalTextStyle: TextStyle(
                  fontSize: 15,
                  fontFamily: "OpenSans",
                  color: LColors.grey.withOpacity(0.3),
                ),
                highlightedTextStyle: TextStyle(
                  fontSize: 20,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.bold,
                  color: LColors.primaryColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Duration",
                style: LTextThemes.mediumTitleBlack,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecorations.primary("hour"),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecorations.primary("mins"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Description or Note",
                style: LTextThemes.mediumTitleBlack,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecorations.primary("Description"),
                maxLines: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
