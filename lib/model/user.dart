import 'package:hive/hive.dart';

class User extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String fullname;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String password;

  User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.password,
  });
}
