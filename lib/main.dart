import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasks/src/tasks_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationSupportDirectory();

  runApp(
    TasksApp(
      directory: dir.path,
    ),
  );
}
