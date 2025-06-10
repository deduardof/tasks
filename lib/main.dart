import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasks/src/models/isar_local_theme.dart';
import 'package:tasks/src/models/task.dart';
import 'package:tasks/src/tasks_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationSupportDirectory();
  final isar = Isar.openSync([TaskSchema, IsarLocalThemeSchema], directory: dir.path);

  runApp(
    TasksApp(isar: isar),
  );
}
