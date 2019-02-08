import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/utils/database_helper.dart';
import 'package:todo_app/screens/add_new_todo.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Todo List",
        home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  State createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<TodoItem> _todoItems = [];
  DatabaseHelper dbhelper;
  _TodoListState() {
    dbhelper = DatabaseHelper();
  }

  @override
  void initState() {
    super.initState();
    dbhelper.getTodos().then((todoList) {
      setState(() {
        _todoItems = todoList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Todo List"),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.add),
        onPressed: _pushAddNewTodoScreen,
      ),
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index]);
        }
      },
    );
  }

  Widget _buildTodoItem(TodoItem todo) {
    return ListTile(
      title: Text(
        todo.todoStatement,
        style: TextStyle(
          fontSize: 20,
          decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          color: todo.isDone ? Colors.blueGrey : Colors.black,
        ),
      ),
      trailing: Checkbox(
        onChanged: (status) {
          setState(() {
            todo.isDone = !todo.isDone;
            dbhelper.updateTodo(todo);
          });
        },
        value: todo.isDone,
      ),
      onLongPress: () {
        _deleteTodoDialog(todo);
      },
    );
  }

  void _pushAddNewTodoScreen() async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddNewTodo();
    }));

    dbhelper.getTodos().then((todoList) {
      setState(() {
        _todoItems = todoList;
      });
    });
  }

  void _deleteTodoDialog(TodoItem todo) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete TODO"),
            content: Text("Do you want to delete \"${todo.todoStatement}\"?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: Navigator.of(context).pop,
              ),
              FlatButton(
                child: Text("Delete"),
                onPressed: () {
                  _removeTodoItem(todo);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _removeTodoItem(TodoItem todo) {
    dbhelper.deleteTodo(todo);
    dbhelper.getTodos().then((todoList) {
      setState(() {
        _todoItems = todoList;
      });
    });
  }
}