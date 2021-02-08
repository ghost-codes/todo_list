import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/BLoCs/createToDo_Bloc.dart';
import 'package:todo_list/core/util/appColors.dart';
import 'package:todo_list/core/util/inputDecorations.dart';
import 'package:todo_list/core/util/textThemes.dart';

class CreateToDoDetails extends StatefulWidget {
  final CreateToDoBloc bloc;

  const CreateToDoDetails({Key key, this.bloc}) : super(key: key);

  // CreateToDoDetails({this.bloc});

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
        actions: [
          FlatButton(
            onPressed: () {
              print("Add");
              widget.bloc.createTodo(context);
            },
            color: LColors.primaryColor,
            child: Text(
              "Add",
              style: LTextThemes.smallBodywhite,
            ),
          ),
        ],
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
          key: widget.bloc.todoKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            children: [
              Text(
                "Title",
                style: LTextThemes.mediumTitleBlack,
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value.length > 3) {
                    return null;
                  } else {
                    return "At least 4 characters";
                  }
                },
                onSaved: (val) {
                  widget.bloc.setTodoTitle(val);
                },
                decoration: InputDecorations.primary("title..."),
              ),
              SizedBox(height: 20),
              Text(
                "Time",
                style: LTextThemes.mediumTitleBlack,
              ),
              TimePickerSpinner(
                time: DateTime.now(),
                onTimeChange: (time) {
                  widget.bloc.setTime(time);
                },
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
                      onSaved: (val) {
                        widget.bloc.setTodohour(val);
                      },
                      decoration: InputDecorations.primary("hour"),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: TextFormField(
                      onSaved: (val) {
                        widget.bloc.setTodoMin(val);
                      },
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
                onSaved: (val) {
                  widget.bloc.setTodoDescription(val);
                },
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
