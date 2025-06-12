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

  Task copyWith({
    int? id,
    String? title,
    String? description,
    List<String>? tags,
    DateTime? createAt,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      createAt: createAt ?? this.createAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
