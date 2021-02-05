import 'package:flutter/material.dart';
import 'package:todo_list/core/util/appColors.dart';
import 'package:todo_list/core/util/textThemes.dart';
import 'package:todo_list/ui/widgets/activityCard.dart';

class CreateToDoView extends StatefulWidget {
  @override
  _CreateToDoViewState createState() => _CreateToDoViewState();
}

class _CreateToDoViewState extends State<CreateToDoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {},
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
            onPressed: () {},
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
                    return Container(
                      margin: EdgeInsets.only(right: 20, top: 10, bottom: 10),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: LColors.primaryColor,
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
                                "5",
                                style: LTextThemes.bigTitleWhite,
                              ),
                              Text(
                                "Mon",
                                style: LTextThemes.tinyFadedAnotePrim,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  if (index == 7) {
                    return Container(
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
                    );
                  }
                  return Container(
                    margin: EdgeInsets.only(right: 20, top: 10, bottom: 10),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: LColors.offWhite,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${5 + index}",
                              style: LTextThemes.bigTitleBlack,
                            ),
                            Text(
                              "Tue",
                              style: LTextThemes.tinyFadedAnoteGrey,
                            ),
                          ],
                        ),
                      ),
                    ),
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
                child: ListView.builder(
                  itemCount: 5 + 1,
                  itemBuilder: (context, index) {
                    return ActivityCard();
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
