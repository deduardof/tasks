import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  final Id id;
  final String title;
  final String description;
  final List<String> tags;
  final DateTime createAt;
  final bool isCompleted;

  Task({
    this.id = Isar.autoIncrement,
    required this.title,
    this.description = '',
    this.tags = const [],
    required this.createAt,
    this.isCompleted = false,
  });

  Task toggle() => Task(
    id: id,
    title: title,
    description: description,
    tags: tags,
    createAt: createAt,
    isCompleted: !isCompleted,
  );
}
