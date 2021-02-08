import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/BLoCs/edit_todoBloc.dart';
import 'package:todo_list/core/models/todo.dart';
import 'package:todo_list/core/util/appColors.dart';
import 'package:todo_list/core/util/inputDecorations.dart';
import 'package:todo_list/core/util/textThemes.dart';

class EditTodoView extends StatefulWidget {
  EditTodoBloc bloc;

  EditTodoView({this.bloc});
  static Widget create(context, ToDo tempTodo) {
    return Provider<EditTodoBloc>(
      create: (context) => EditTodoBloc(tempTodo),
      child: Consumer<EditTodoBloc>(builder: (context, bloc, _) {
        return EditTodoView(bloc: bloc);
      }),
    );
  }

  @override
  _EditTodoViewState createState() => _EditTodoViewState();
}

class _EditTodoViewState extends State<EditTodoView> {
  @override
  Widget build(BuildContext context) {
    TimeOfDay t = TimeOfDay(
        hour: int.parse(widget.bloc.tempTodo.datetime.split(":")[0]),
        minute: int.parse(widget.bloc.tempTodo.datetime.split(":")[1]));
    print(widget.bloc.tempTodo.duration);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LColors.white,
        shadowColor: Colors.transparent,
        actions: [
          FlatButton(
            onPressed: () {
              widget.bloc.editTodo(context);
            },
            color: LColors.primaryColor,
            child: Text(
              "Done",
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
                initialValue: widget.bloc.tempTodo.title,
                decoration: InputDecorations.primary("title..."),
              ),
              SizedBox(height: 20),
              Text(
                "Time",
                style: LTextThemes.mediumTitleBlack,
              ),
              TimePickerSpinner(
                time: DateTime(DateTime.now().year, 1, 1, t.hour, t.minute),
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
                      keyboardType: TextInputType.number,
                      initialValue:
                          (widget.bloc.tempTodo.duration.split(":")[0]),
                      decoration: InputDecorations.primary("hour"),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: TextFormField(
                      onSaved: (val) {
                        widget.bloc.setTodoMin(val);
                      },
                      keyboardType: TextInputType.number,
                      initialValue:
                          (widget.bloc.tempTodo.duration.split(":")[1]),
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
                initialValue: widget.bloc.tempTodo.description,
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
