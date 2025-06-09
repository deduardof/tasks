import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks/src/core/constants/app_sizes.dart';
import 'package:tasks/src/core/constants/titles_app.dart';
import 'package:tasks/src/features/tasks/tasks_bloc.dart';
import 'package:tasks/src/features/tasks/tasks_event.dart';
import 'package:tasks/src/features/tasks/tasks_state.dart';
import 'package:tasks/src/models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<TasksBloc>().add(LoadTasksEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(TitlesApp.taskTitle)),
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          final tasks = state.tasks;
          return (tasks.isEmpty)
              ? Center(
                  child: Text('Não há tarefas agendadas.'),
                )
              : ListView.separated(
                  itemBuilder: (_, index) {
                    final task = tasks[index];
                    return ListTile(
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) {
                          context.read<TasksBloc>().add(ToggleTaskEvent(task));
                        },
                      ),
                      title: Text(task.title),
                      subtitle: (task.description.isNotEmpty) ? Text(task.description) : null,
                    );
                  },
                  separatorBuilder: (_, _) => Divider(),
                  itemCount: tasks.length,
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          String title = '';
          String description = '';
          final formKey = GlobalKey<FormState>();
          final task = await showDialog<Task?>(
            context: context,
            builder: (_) {
              return Dialog.fullscreen(
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.defaultPadding),
                  child: Form(
                    key: formKey,
                    child: Column(
                      spacing: AppSizes.defaultPadding,
                      children: [
                        Text(
                          'Adicionar tarefa',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TextFormField(
                          initialValue: title,
                          onChanged: (value) => title = value,
                          decoration: InputDecoration(),
                          validator: (value) => (value?.isEmpty ?? true) ? 'Campo obrigatório.' : null,
                        ),
                        TextFormField(
                          initialValue: description,
                          onChanged: (value) => description = value,
                          decoration: InputDecoration(),
                        ),
                        FilledButton.icon(
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              final now = DateTime.now();
                              final task = Task(
                                id: now.millisecondsSinceEpoch,
                                title: title,
                                description: description,
                                createAt: now,
                              );
                              context.pop(task);
                            }
                          },
                          label: Text('Adicionar'),
                          icon: Icon(Icons.check),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
          if (task != null) {
            // ignore: use_build_context_synchronously
            context.read<TasksBloc>().add(AddTaskEvent(task));
          }
        },
      ),
    );
  }
}
