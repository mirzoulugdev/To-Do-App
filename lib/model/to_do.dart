import 'package:hive/hive.dart';

class ToDo extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final DateTime? date;
  @HiveField(3)
  bool isDone = false;

  ToDo({
    required this.id,
    required this.title,
    required this.date,
    required this.isDone,
  });
}
