import 'dart:async';
import 'package:brahimdb/database/dal/sql_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:brahimdb/models/tasks.dart';

class DataBaseMethod {
  static Future<int> addData(Task task) async {
    Database myDatabase = await DataBaseHelper.getDB();
    var result = await myDatabase.insert("tasks", task.toMap());
    return result;
  }

  static Future<List> getMyData() async {
    Database myDatabase = await DataBaseHelper.getDB();
    List<Map> tasks = await myDatabase.rawQuery("select * from tasks");
//    List<Map> tasks = await myDatabase
//        .query("tasks", columns: ['name', "age", "salary", "dep"]);
    return tasks.toList();
  }

  static Future<int> deleteData(String condition) async {
    Database myDatabase = await DataBaseHelper.getDB();
    return await myDatabase.delete("tasks", where: "$condition");
  }

  static Future<int> updateValues(
      int id, Task newTask) async {
    Database myDatabase = await DataBaseHelper.getDB();
    newTask.id = id;
    var result =
        await myDatabase.update("tasks", newTask.toMap(), where: 'id = $id');
    return result;
  }
}
