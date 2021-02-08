import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo_list/core/BLoCs/createToDo_Bloc.dart';
import 'package:todo_list/core/models/activity.dart';
import 'package:todo_list/core/util/appColors.dart';
import 'package:todo_list/core/util/inputDecorations.dart';
import 'package:todo_list/core/util/textThemes.dart';
import 'package:todo_list/ui/widgets/activityCard.dart';

class CreateToDoView extends StatefulWidget {
  CreateToDoBloc bloc;

  CreateToDoView({this.bloc});
  static Widget create(BuildContext context) {
    return Provider<CreateToDoBloc>(
      create: (context) => CreateToDoBloc(),
      child: Consumer<CreateToDoBloc>(builder: (context, bloc, _) {
        return CreateToDoView(bloc: bloc);
      }),
    );
  }

  @override
  _CreateToDoViewState createState() => _CreateToDoViewState();
}

class _CreateToDoViewState extends State<CreateToDoView> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "",
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                  child: AlertDialog(
                    content: Form(
                      key: widget.bloc.activityKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: LTextThemes.mediumTitleBlack,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              validator: (val) {
                                if (val.length > 3) {
                                  return null;
                                }
                                return "More than 3 characters";
                              },
                              onSaved: (val) {
                                widget.bloc.activityName(val);
                                setState(() {});
                              },
                              decoration: InputDecorations.primary("name..."),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Description or Note",
                              style: LTextThemes.mediumTitleBlack,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              onSaved: (val) {
                                widget.bloc.activityDescription(val);
                              },
                              decoration:
                                  InputDecorations.primary("Description"),
                              maxLines: 5,
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: LTextThemes.smallBodyBlack,
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    widget.bloc.createActivity(context);
                                    // Navigator.of(context).pop();
                                  },
                                  color: LColors.primaryColor,
                                  child: Text(
                                    "Add",
                                    style: LTextThemes.smallBodywhite,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: LColors.primaryColor,
            child: Icon(Icons.add, color: LColors.white),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/create_task_details',
                  arguments: widget.bloc);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: LColors.primaryColor,
            child: Icon(Icons.arrow_forward, color: LColors.white),
          ),
        ],
      ),
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
          "Create Task",
          style: LTextThemes.bigTitleBlack,
        ),
      ),
      body: Container(
        color: LColors.white,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 20),
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return GestureDetector(
                      onTap: () {
                        widget.bloc.settemDate(
                            DateTime.now().add(Duration(days: index)));
                      },
                      child: StreamBuilder<DateTime>(
                          stream: widget.bloc.temprDate,
                          initialData: DateTime.now(),
                          builder: (context, snapshot) {
                            return Container(
                              margin: EdgeInsets.only(
                                  right: 20, top: 10, bottom: 10),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: LColors.primaryColor,
                                    border: DateFormat("yyyy-MM-dd")
                                                .format(snapshot.data) ==
                                            DateFormat("yyyy-MM-dd").format(
                                                DateTime.now()
                                                    .add(Duration(days: index)))
                                        ? Border.all(
                                            color: LColors.black,
                                            width: 5,
                                            style: BorderStyle.solid)
                                        : Border.fromBorderSide(
                                            BorderSide.none),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 7,
                                          offset: Offset(2, 4),
                                          color: LColors.black.withOpacity(0.2))
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${DateTime.now().day}",
                                        style: LTextThemes.bigTitleWhite,
                                      ),
                                      Text(
                                        "${DateFormat("EEE").format(DateTime.now())}",
                                        style: LTextThemes.tinyFadedAnotePrim,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                  if (index == 7) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierColor: LColors.black.withOpacity(0.15),
                          builder: (context) => BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                            child: AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SfDateRangePicker(
                                    selectionMode:
                                        DateRangePickerSelectionMode.single,
                                    onSelectionChanged:
                                        (DateRangePickerSelectionChangedArgs
                                            date) {
                                      widget.bloc.tempDate = date.value;
                                      print(date.value);
                                    },
                                    todayHighlightColor: LColors.primaryColor,
                                    selectionColor: LColors.primaryColor,
                                    minDate: DateTime.now(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20, top: 10, bottom: 10),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: LColors.secondaryPale,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 7,
                                    offset: Offset(2, 4),
                                    color: LColors.black.withOpacity(0.2))
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(Icons.add, color: LColors.white),
                          ),
                        ),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () {
                      widget.bloc.settemDate(
                          DateTime.now().add(Duration(days: index)));
                    },
                    child: StreamBuilder<DateTime>(
                        stream: widget.bloc.temprDate,
                        initialData: DateTime.now(),
                        builder: (context, snapshot) {
                          return Container(
                            margin:
                                EdgeInsets.only(right: 20, top: 10, bottom: 10),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: LColors.offWhite,
                                  border: DateFormat("yyyy-MM-dd")
                                              .format(snapshot.data) ==
                                          DateFormat("yyyy-MM-dd").format(
                                              DateTime.now()
                                                  .add(Duration(days: index)))
                                      ? Border.all(
                                          color: LColors.black,
                                          width: 5,
                                          style: BorderStyle.solid)
                                      : Border.fromBorderSide(BorderSide.none),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${DateTime.now().add(Duration(days: index)).day}",
                                      style: LTextThemes.bigTitleBlack,
                                    ),
                                    Text(
                                      "${DateFormat("EEE").format(DateTime.now().add(Duration(days: index)))}",
                                      style: LTextThemes.tinyFadedAnoteGrey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Choose Activity", style: LTextThemes.bigTitleBlack),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: StreamBuilder<List<Activity>>(
                  stream: widget.bloc.activityList,
                  initialData: [],
                  builder: (context, snapshot) {
                    if (snapshot.data.length == 0 || snapshot.data == null) {
                      return Center(child: Text("No Activity found"));
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return StreamBuilder<String>(
                            stream: widget.bloc.selectedActivity,
                            initialData: '',
                            builder: (context, act) {
                              widget.bloc.temprActivity = act.data;
                              print(act.data);
                              print(widget.bloc.temprActivity);
                              return ActivityCard(
                                activity: snapshot.data[index],
                                groupRadio: act.data,
                              );
                            });
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
