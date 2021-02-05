import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/core/models/todo.dart';
import 'package:todo_list/core/util/appColors.dart';
import 'package:todo_list/core/util/textThemes.dart';
import 'package:todo_list/ui/widgets/exportWidgets.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: LColors.primaryColor,
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                topWithDate(),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: LColors.white,
                      ),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            List<ToDo> todoList = [
                              ToDo(
                                  title: "Hope",
                                  description: "Dorkenoo",
                                  category: "School",
                                  timeFrame: "11:00 - 12:00"),
                              ToDo(
                                  title: "Hope",
                                  description: "Dorkenoo",
                                  category: "School",
                                  timeFrame: "11:00 - 12:00"),
                              ToDo(
                                  title: "Hope",
                                  description: "Dorkenoo",
                                  category: "School",
                                  timeFrame: "11:00 - 12:00"),
                              ToDo(
                                  title: "Hope",
                                  description: "Dorkenoo",
                                  category: "School",
                                  timeFrame: "11:00 - 12:00"),
                              ToDo(
                                  title: "Hope",
                                  description: "Dorkenoo",
                                  category: "School",
                                  timeFrame: "11:00 - 12:00"),
                              ToDo(
                                  title: "Hope",
                                  description: "Dorkenoo",
                                  category: "School",
                                  timeFrame: "11:00 - 12:00"),
                            ];
                            // if (index == 0) {
                            //   return Container(
                            //     color: Colors.black,
                            //     height: 70,
                            //     child: ListView.builder(
                            //       itemCount: 10,
                            //       itemBuilder: (context, index) {
                            //         return Container(
                            //           color: LColors.grey,
                            //           width: 50,
                            //           margin: EdgeInsets.all(10),
                            //         );
                            //       },
                            //     ),
                            //   );
                            // }
                            return ToDoItemCard(toDo: todoList[index]);
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topWithDate() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.grid_view,
                  color: LColors.white,
                  size: 18,
                ),
              ),
              Text(
                "Today Date",
                style: LTextThemes.smallBodywhite,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.alarm,
                  color: LColors.white,
                  size: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Today", style: LTextThemes.bigTitleWhite),
                  Text("8 tasks", style: LTextThemes.tinyFadedAnotePrim),
                ],
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/create_task');
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: LColors.white,
                // height: 50,
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Text(
                    "Add New",
                    style: LTextThemes.smallBodyPrim,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
