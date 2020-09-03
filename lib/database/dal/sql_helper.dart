import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart' as PP;
import 'package:path/path.dart';

class DataBaseHelper {
  static Database _db;
  static String dataBasePath ;
  static String dataBaseName = "tasks.db";
  static String dataBaseStatement =
      """CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, 
              task VARCHAR(20), 
              priority INTEGER,
              completed INTEGER,
              description VARCHAR(50)
              )""";

  static Future<Database> getDB() async {
    if (_db == null) {
      _db = await openDB();
    }
    return _db;
  }

  static Future<Database> openDB() async {
    Directory dir = await PP.getApplicationDocumentsDirectory();
    String path = join(dir.path, dataBaseName);
    dataBasePath = path;

    var task = openDatabase(path, version: 1, onCreate: _createFirst);
    return task;
  }

  static void restartDB() async {
    Directory dir = await PP.getApplicationDocumentsDirectory();
    String path = join(dir.path, dataBaseName);
    File f = new File(path);
    dataBasePath = path;
    if (!f.existsSync()) {
      deleteDatabase(path);
      getDB();
      print("Database Deleted");
    }
  }

  static void _createFirst(Database db, int version) async {
    await db.execute(dataBaseStatement);
  }

  static Future<void> closeDB() async {
    var db = await getDB();
    db.close();
    _db = null;
  }
}
