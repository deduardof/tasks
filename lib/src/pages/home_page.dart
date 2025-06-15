import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks/src/core/constants/app_sizes.dart';
import 'package:tasks/src/core/constants/titles_app.dart';
import 'package:tasks/src/features/tasks/tasks_bloc.dart';
import 'package:tasks/src/features/tasks/tasks_event.dart';
import 'package:tasks/src/features/tasks/tasks_state.dart';
import 'package:tasks/src/features/themes/theme_cubit.dart';
import 'package:tasks/src/models/task.dart';
import 'package:tasks/src/pages/widgets/task_dialog.dart';
import 'package:tasks/src/pages/widgets/task_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TasksBloc tasksBloc;
  late final ThemeCubit themeCubit;
  final TextEditingController tagController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tasksBloc = context.read<TasksBloc>();
    themeCubit = context.read<ThemeCubit>();
    Future.delayed(Duration.zero, () async {
      await themeCubit.loadTheme();
    });
    tasksBloc.add(LoadTasksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TitlesApp.taskTitle),
        actions: [
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) => IconButton(
              onPressed: () async {
                themeCubit.toggleTheme();
              },
              icon: Icon(
                (themeMode == ThemeMode.light) ? Icons.dark_mode : Icons.light_mode_outlined,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          final tasks = state.tasks;
          return (tasks.isEmpty)
              ? Center(
                  child: Text('Não há tarefas agendadas.'),
                )
              : ListView.separated(
                  padding: EdgeInsets.all(
                    AppSizes.minPadding,
                  ),
                  itemBuilder: (_, index) {
                    final task = tasks[index];
                    return TaskItem(
                      task: task,
                      onTap: () async {
                        final response = await showDialog<Task?>(
                          context: context,
                          builder: (context) => TaskDialog(task: task),
                        );
                        if (response != null) {
                          final taskEdited = task.copyWith(
                            title: response.title,
                            description: response.description,
                            tags: response.tags,
                          );
                          // ignore: use_build_context_synchronously
                          context.read<TasksBloc>().add(UpdateTaskEvent(taskEdited));
                        }
                      },
                    );
                    /* ListTile(
                      tileColor: context.colors.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSizes.defaultRadius,
                        ),
                      ),
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) {
                          context.read<TasksBloc>().add(ToggleTaskEvent(task));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.minRadius,
                          ),
                        ),
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: (task.isCompleted) ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      subtitle: (task.description.isNotEmpty)
                          ? Text(
                              task.description,
                              style: TextStyle(
                                decoration: (task.isCompleted) ? TextDecoration.lineThrough : null,
                              ),
                            )
                          : null,

                      onTap: () async {
                        final response = await showDialog<Task?>(
                          context: context,
                          builder: (context) => TaskDialog(task: task),
                        );
                        if (response != null) {
                          final taskEdited = task.copyWith(
                            title: response.title,
                            description: response.description,
                            tags: response.tags,
                          );
                          // ignore: use_build_context_synchronously
                          context.read<TasksBloc>().add(UpdateTaskEvent(taskEdited));
                        }
                      },
                    ); */
                  },
                  separatorBuilder: (_, _) => SizedBox(height: 2),
                  itemCount: tasks.length,
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/task/types');
          /* showModalBottomSheet(
            context: context,
            //isScrollControlled: true,
            enableDrag: true,
            builder: (context) {
              return TaskTypeSelectBottom();
            },
          ); */
        },
        child: Icon(Icons.add),
      ), //AddTaskFloatingActionButton(),
    );
  }
}
