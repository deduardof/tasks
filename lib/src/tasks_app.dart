import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:tasks/src/core/routes/routes_app.dart';
import 'package:tasks/src/core/themes/app_themes.dart';
import 'package:tasks/src/data/repositories/isar_local_repository.dart';
import 'package:tasks/src/data/repositories/isar_theme_repository.dart';
import 'package:tasks/src/data/repositories/local_repository.dart';
import 'package:tasks/src/features/tasks/tasks_bloc.dart';
import 'package:tasks/src/features/themes/theme_cubit.dart';

class TasksApp extends StatelessWidget {
  const TasksApp({super.key, required this.isar});
  final Isar isar;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
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
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) => MaterialApp.router(
          routerConfig: routesApp,
          themeMode: themeMode,
          theme: ThemeData(colorScheme: schemeLight),
          darkTheme: ThemeData(colorScheme: schemeDark),
        ),
      ),
    );
  }
}
