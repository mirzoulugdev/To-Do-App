import 'package:hive/hive.dart';
import 'package:to_do_app/model/user.dart';

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final id = reader.read() as String;
    final fullname = reader.read() as String;
    final email = reader.read() as String;
    final password = reader.read() as String;

    return User(id: id, fullname: fullname, email: email, password: password);
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.write(obj.id);
    writer.write(obj.fullname);
    writer.write(obj.email);
    writer.write(obj.password);
  }
}
