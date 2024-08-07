import 'package:brahimdb/database/bl/data_methods.dart';
import 'package:brahimdb/models/tasks.dart';
import 'package:brahimdb/utils/constants.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:flutter/cupertino.dart';

addScreen(_, Function state) {
  TextEditingController taskName = new TextEditingController();
  TextEditingController description = new TextEditingController();
  int priority = 1;

  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: _,
    builder: (context) {
      return BackdropFilter(
        filter: kBlurFilter,
        child: Container(
          height: height * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            color: Colors.black54,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Column(
              children: <Widget>[
                SizedBox(height: height * 0.03),
                inputTask(taskName, 'Task title'),
                inputTask(description, 'Desription'),
                SizedBox(height: height * 0.01),
                Text("Priority"),
                SizedBox(height: height * 0.01),
                Container(
                  height: height * 0.1,
                  margin: EdgeInsets.symmetric(horizontal: width * 0.15),
                  child: CupertinoPicker(
                    backgroundColor: Colors.transparent,
                    children: <Widget>[
                      Text("A", style: TextStyle(color: Color(0xffBD4567))),
                      Text("B", style: TextStyle(color: Colors.orange)),
                      Text("C", style: TextStyle(color: Colors.yellow)),
                    ],
                    itemExtent: 30,
                    onSelectedItemChanged: (int value) {
                      priority = value + 1;
                    },
                  ),
                ),
                SizedBox(height: height * 0.03),
                RaisedButton(
                  color: Color(0xffBD4567),
                  child: Text('Add'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    if (taskName.text != "" && description.text != "") {
                      DataBaseMethod.addData(
                        new Task(taskName.text, priority, 0, description.text),
                      );
                    }
                    state();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget inputTask(TextEditingController controller, String txt) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: height * 0.02),
    height: height * 0.09,
    child: TextField(
      maxLines: 1,
      controller: controller,
      decoration: InputDecoration(
        hintText: txt,
        hintStyle: TextStyle(color: Colors.white30),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: primaryColor, width: 1.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: primaryColor, width: 1.0),
        ),
      ),
    ),
  );
}
