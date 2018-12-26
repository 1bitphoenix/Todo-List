import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
   ValueNotifier<Client> client = ValueNotifier(
    Client(
      endPoint: 'https://todo-flutter.herokuapp.com/v1alpha1/graphql',
      cache: InMemoryCache(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Todo List',
      home: new TodoList()
    );
  }
}