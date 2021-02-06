import 'package:flutter/material.dart';
import 'package:todo_list/core/models/activity.dart';
import 'package:todo_list/core/util/appColors.dart';
import 'package:todo_list/core/util/textThemes.dart';

class ActivityCard extends StatefulWidget {
  final Activity activity;

  const ActivityCard({Key key, this.activity}) : super(key: key);
  @override
  _ActivityCardState createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: LColors.offWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.activity.name,
                style: LTextThemes.mediumTitleBlack,
              ),
              Text(
                "13 Tasks this week",
                style: LTextThemes.tinyFadedAnoteGrey,
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios, color: LColors.primaryColor),
        ],
      ),
    );
  }
}
