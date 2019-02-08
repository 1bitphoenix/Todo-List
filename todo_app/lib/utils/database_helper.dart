import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/models/todo_item.dart';

class DatabaseHelper {

//1
  static DatabaseHelper _databaseHelper;

//4
  static Database _database;

//3
  DatabaseHelper._createInstance();

//2
  factory DatabaseHelper(){
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

//5
  Future<Database> get db async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDb();
      return _database;
    }
  }


  initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "todo.db");

    var db = openDatabase(path, onCreate: _onCreate, version: 1);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Todos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        todoStatement TEXT NOT NULL,
        isdone INTEGER NOT NULL
      )
      ''');
  }

  Future<List<TodoItem>> getTodos() async{
    var dbClient = await db;
    List<Map<String,dynamic>> list = await dbClient.query("Todos");
    List<TodoItem> todoList = list.map((jsonMap)=>TodoItem.fromMap(jsonMap)).toList();
    return todoList;
  }

  void insertTodo(TodoItem todo) async{
    var dbClient = await db;
    await dbClient.insert("Todos", todo.toMap());
  }
  
  void deleteTodo(TodoItem todo) async{
    var dbClient = await db;
    await dbClient.delete("Todos", where: "todoStatement = ?", whereArgs: [todo.todoStatement]);
  }

  void updateTodo(TodoItem todo, ) async{
    var dbClient = await db;
    await dbClient.update("Todos", todo.toMap(), where: "todoStatement = ?", whereArgs: [todo.todoStatement]);
  }
}
