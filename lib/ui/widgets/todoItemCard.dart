import 'package:flutter/material.dart';
import 'package:todo_list/core/models/todo.dart';
import 'package:todo_list/core/util/appColors.dart';
import 'package:todo_list/core/util/textThemes.dart';

class ToDoItemCard extends StatefulWidget {
  final ToDo toDo;

  const ToDoItemCard({Key key, this.toDo}) : super(key: key);
  @override
  _ToDoItemCardState createState() => _ToDoItemCardState();
}

class _ToDoItemCardState extends State<ToDoItemCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: false ? LColors.primaryColor : Colors.transparent,
              boxShadow: false
                  ? [
                      BoxShadow(
                          color: LColors.black.withOpacity(0.1),
                          offset: Offset(2, 4),
                          blurRadius: 7)
                    ]
                  : [],
            ),
            child: Row(
              children: [
                //Checkbox
                Container(
                  width: 25,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            border: Border.all(
                              style: BorderStyle.solid,
                              color: LColors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // width: 25,
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: LColors.primaryColor,
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.toDo.title}",
                        style: LTextThemes.smallBodyBlack,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${widget.toDo.timeFrame}",
                        style: LTextThemes.tinyFadedAnotePrim,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
