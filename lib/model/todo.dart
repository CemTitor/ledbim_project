import 'package:uuid/uuid.dart';

class Todo {
  final String id = const Uuid().v1();
  String? name;
  bool isDone = false;

  Todo({required this.name});
}