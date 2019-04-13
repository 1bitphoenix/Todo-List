import 'package:flutter/material.dart';
import 'package:todo_app/utils/database_helper.dart';
import 'package:todo_app/models/todo_item.dart';

class AddNewTodo extends StatelessWidget {
  DatabaseHelper dbHelper;
  AddNewTodo() {
    dbHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add new Todo"),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: TextField(
            autofocus: true,
            onSubmitted: (text) {
              dbHelper.insertTodo(TodoItem(todoStatement: text,isDone: false));
              Navigator.of(context).pop();
            },
            decoration: InputDecoration(
              hintText: "Enter Something to do ...",
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      );
  }
}
