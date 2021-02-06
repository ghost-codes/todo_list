import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/BLoCs/homeBloc.dart';
import 'package:todo_list/core/models/todo.dart';
import 'package:todo_list/core/util/appColors.dart';
import 'package:todo_list/core/util/textThemes.dart';
import 'package:todo_list/ui/widgets/exportWidgets.dart';

class HomeView extends StatefulWidget {
  HomeBloc bloc;

  HomeView({this.bloc});

  static Widget create(BuildContext context) {
    return Provider<HomeBloc>(
      create: (_) => HomeBloc(),
      child: Consumer<HomeBloc>(builder: (context, bloc, _) {
        return HomeView(bloc: bloc);
      }),
    );
  }

  @override
  _HomeViewState createState() => _HomeViewState(bloc: bloc);
}

class _HomeViewState extends State<HomeView> {
  HomeBloc bloc;
  _HomeViewState({this.bloc});

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
                      child: StreamBuilder<List<ToDo>>(
                        stream: bloc.todoList,
                        initialData: [],
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: SpinKitChasingDots(
                                color: LColors.primaryColor,
                                size: 50,
                              ),
                            );
                          }
                          if (snapshot.data.length == 0) {
                            return Center(
                                child: Text("No Tasks Here",
                                    style: LTextThemes.mediumTitleBlack));
                          }
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return ToDoItemCard(toDo: snapshot.data[index]);
                            },
                          );
                        },
                      ),
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
    DateTime now = DateTime.now();
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
                // "\${now.day} \${DateFormat(\"MMMM\").parse(now.month)}",
                "${now.day}",
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
                  StreamBuilder<List<ToDo>>(
                      stream: bloc.todoList,
                      builder: (context, snapshot) {
                        return Text(
                            "${(snapshot.data == null) ? 0 : snapshot.data.length} tasks",
                            style: LTextThemes.tinyFadedAnotePrim);
                      }),
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
