import 'package:audioplayers/audio_cache.dart';
import 'package:brahimdb/models/tasks.dart';
import 'package:brahimdb/screens/add_screen.dart';
import 'package:brahimdb/utils/about_task.dart';
import 'package:brahimdb/utils/app_bar.dart';
import 'package:brahimdb/utils/constants_timer_screen.dart';
import 'package:brahimdb/utils/drawer.dart';
import 'package:flutter/material.dart';
import 'package:brahimdb/database/bl/data_methods.dart';

double height;
double width;

class HomeScreen extends StatefulWidget {
  static const id = "/";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  Future getTasks() async {
    DataBaseMethod.getMyData().then((onValue) {
      setState(() {
        tasks = [];
        for (var i in onValue) {
          tasks.add(new Task.toMAP(i));
        }
      });
    });
    return tasks;
  }

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MyDrawer(),
      body: Container(
        decoration: kBackgroundImage,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              AppBarCustmize(context),
              FutureBuilder(
                future: getTasks(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(child: _tasksList());
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addScreen(context, () {
            setState(() {});
          });
        },
        child: Icon(Icons.add_circle_outline),
        backgroundColor: Color(0xffBD4567),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _tasksList() {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (_, index) {
        return ListTile(
          title: Text(
            tasks[index].task,
            style: TextStyle(
              decoration: tasks[index].completed != 0
                  ? TextDecoration.lineThrough
                  : null,
            ),
          ),
          subtitle: Text(
            tasks[index].description.length < 20
                ? tasks[index].description
                : tasks[index].description.substring(0, 20) + "...",
            style: TextStyle(
              decoration: tasks[index].completed != 0
                  ? TextDecoration.lineThrough
                  : null,
            ),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (_) {
                  return BackdropFilter(
                    filter: kBlurFilter,
                    child: aboutTask(
                      _,
                      title: tasks[index].task,
                      description: tasks[index].description,
                      done: tasks[index].completed,
                    ),
                  );
                });
          },
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                DataBaseMethod.deleteData("id = ${tasks[index].id}");
              });
            },
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: priorityColor(tasks[index].priority)[0],
                child: Text(priorityColor(tasks[index].priority)[1]),
                radius: height * 0.025,
              ),
              Checkbox(
                value: tasks[index].completed == 0 ? false : true,
                onChanged: (value) {
                  setState(() {
                    Task newTask = tasks[index];
                    newTask.completed = value ? 1 : 0;
                    DataBaseMethod.updateValues(newTask.id, newTask);
                  });
                  if(value){
                    final player = AudioCache();
                    player.play('audio/checked.wav');
                  }
                  print(tasks[index].toMap());
                },
                activeColor: Color(0xffBD4567),
              ),
            ],
          ),
        );
      },
    );
  }

  List priorityColor(int priority) {
    if (priority == 1) {
      return [Color(0xffBD4567), 'A'];
    } else if (priority == 2) {
      return [Colors.orange, 'B'];
    } else {
      return [Colors.yellow, 'C'];
    }
  }
}
