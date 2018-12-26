import 'package:flutter/material.dart';


class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}
class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  void _addTodoItem(String task) {
    if(task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }
  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Mark "${_todoItems[index]}" as done?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop()
            ),
            new FlatButton(
              child: new Text('MARK AS DONE'),
              onPressed: () {
                _removeTodoItem(index);
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );
  }

  Widget _titleOfList(){
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
        ),
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey, fontSize: 30.0),
      )
    );
  }

  List<Widget> _buildTodoList() {

    List<Widget> _todoList = List();
    _todoList.add(_titleOfList());

    for(int i = 0 ; i < _todoItems.length; i++){

      bool check = true;

      _todoList.add(Padding(
          padding: const EdgeInsets.all(20.0),
          child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            _todoItems[i], 
            style: TextStyle(fontSize: 20.0),
          ),
          GestureDetector(
            onTap: () => _promptRemoveTodoItem(i),
            child: Icon(Icons.done, color: Colors.black)),
        ],
    ),
        )
      );
    }
    return _todoList;
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // pinned: true,
            floating: true,
            expandedHeight: 50.0,
            backgroundColor: Colors.cyan,
            flexibleSpace: new FlexibleSpaceBar(
              title: new Text("Todo List"),
            ),
          ),
          new SliverList(
          delegate: new SliverChildListDelegate(_buildTodoList()),),
    ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: new Icon(Icons.add)
      ),
    );
  }


void _pushAddTodoScreen() {
  Navigator.of(context).push(
    
    new MaterialPageRoute(
      builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Add a new task')
          ),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context);
            },
            decoration: new InputDecoration(
              hintText: 'Enter something to do...',
              contentPadding: const EdgeInsets.all(16.0)
            ),
          )
        );
    }));
  }
}