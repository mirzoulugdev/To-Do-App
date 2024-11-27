import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../model/to_do.dart';

class Todos extends ChangeNotifier {
  final todoBox = Hive.box("todos");
  late List<ToDo> _list;

  Todos() {
    _initializeList();
  }


  void _initializeList() {
    _list = todoBox.values.toList().cast<ToDo>();
    notifyListeners();
  }


  List<ToDo> get todoList {
    return [..._list];
  }

  void addTodo({
    required String title,
    required DateTime date,
    required bool isDone,
  }) {
    final newTodo = ToDo(
      id: UniqueKey().toString(),
      title: title,
      date: date,
      isDone: isDone,
    );


    todoBox.add(newTodo);


    _list = todoBox.values.toList().cast<ToDo>();
    notifyListeners();
  }


  void deleteTodo({required int index}) {
    final key = todoBox.keyAt(index);

   
    todoBox.delete(key);

 
    _list = todoBox.values.toList().cast<ToDo>();
    notifyListeners(); 
  }
}
