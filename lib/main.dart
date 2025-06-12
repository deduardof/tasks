import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasks/src/data/repositories/isar_local_repository.dart';
import 'package:tasks/src/data/repositories/isar_theme_repository.dart';
import 'package:tasks/src/data/repositories/local_repository.dart';
import 'package:tasks/src/features/tasks/tasks_bloc.dart';
import 'package:tasks/src/features/themes/theme_cubit.dart';
import 'package:tasks/src/models/isar_local_theme.dart';
import 'package:tasks/src/models/task.dart';
import 'package:tasks/src/tasks_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationSupportDirectory();
  final isar = Isar.openSync([TaskSchema, IsarLocalThemeSchema], directory: dir.path);

  runApp(
    MultiBlocProvider(
      providers: [
        RepositoryProvider<LocalRepository>(
          create: (_) => IsarLocalRepository(isar),
        ),
        RepositoryProvider<IsarThemeRepository>(
          create: (_) => IsarThemeRepository(isar),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(
            context.read<IsarThemeRepository>(),
          ),
        ),
        BlocProvider<TasksBloc>(
          create: (context) => TasksBloc(
            context.read<LocalRepository>(),
          ),
        ),
      ],
      child: TasksApp(),
    ),
  );
}
