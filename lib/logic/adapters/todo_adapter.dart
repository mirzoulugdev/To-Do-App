import 'package:hive/hive.dart';
import '../../model/to_do.dart';

class TodoAdapter extends TypeAdapter<ToDo> {
  @override
  final int typeId = 0;

  @override
  ToDo read(BinaryReader reader) {
    final id = reader.read() as String;
    final title = reader.read() as String;
    final date = reader.read() as DateTime;
    final isDone = reader.read() as bool;

    return ToDo(id: id, title: title, date: date, isDone: isDone);
  }

  @override
  void write(BinaryWriter writer, ToDo obj) {
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.date);
    writer.write(obj.isDone);
  }
}
