import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../model/to_do.dart';

class Todos extends ChangeNotifier {
  final todoBox = Hive.box("todos");
  late List<ToDo> _list;

  Todos() {
    _initializeList();
  }

  // Ro'yxatni boshlang'ich yuklash
  void _initializeList() {
    _list = todoBox.values.toList().cast<ToDo>();
    notifyListeners(); // Ekranni yangilash
  }

  // Foydalanuvchi uchun ro'yxatni olish
  List<ToDo> get todoList {
    return [..._list];
  }

  // Yangi vazifa qo'shish
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

    // Qutiga qo'shish
    todoBox.add(newTodo);

    // `_list` ro'yxatini yangilash
    _list = todoBox.values.toList().cast<ToDo>();
    notifyListeners(); // Ekranni yangilash
  }

  // Vazifani o'chirish
  void deleteTodo({required int index}) {
    final key = todoBox.keyAt(index);

    // Qutidan o'chirish
    todoBox.delete(key);

    // `_list` ro'yxatini yangilash
    _list = todoBox.values.toList().cast<ToDo>();
    notifyListeners(); // Ekranni yangilash
  }
}
