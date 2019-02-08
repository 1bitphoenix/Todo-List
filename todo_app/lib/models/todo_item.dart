class TodoItem {
  String todoStatement;
  bool isDone ;

  TodoItem({String todoStatement, bool isDone}) {
    this.todoStatement = todoStatement;
    this.isDone = isDone;
  }

  factory TodoItem.fromMap(Map<String, dynamic> map) =>
      TodoItem(todoStatement: map['todoStatement'], isDone: map['isdone']==1);

  Map<String, dynamic> toMap() =>
      {"todoStatement": todoStatement, "isdone": isDone ? 1 : 0};
}
