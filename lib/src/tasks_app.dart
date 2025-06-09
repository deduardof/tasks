import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/src/core/routes/routes_app.dart';
import 'package:tasks/src/data/repositories/isar_local_repository.dart';
import 'package:tasks/src/data/repositories/local_repository.dart';
import 'package:tasks/src/features/tasks/tasks_bloc.dart';

class TasksApp extends StatelessWidget {
  const TasksApp({super.key, required this.directory});
  final String directory;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<LocalRepository>(
          lazy: false,
          create: (_) => IsarLocalRepository(directory),
        ),
        BlocProvider<TasksBloc>(
          create: (context) => TasksBloc(
            context.read<LocalRepository>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: routesApp,
      ),
    );
  }
}
