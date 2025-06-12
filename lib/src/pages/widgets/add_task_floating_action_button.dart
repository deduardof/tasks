import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/src/features/tasks/tasks_bloc.dart';
import 'package:tasks/src/features/tasks/tasks_event.dart';
import 'package:tasks/src/models/task.dart';
import 'package:tasks/src/pages/widgets/task_dialog.dart';

class AddTaskFloatingActionButton extends StatefulWidget {
  const AddTaskFloatingActionButton({super.key});

  @override
  State<AddTaskFloatingActionButton> createState() => _AddTaskFloatingActionButtonState();
}

class _AddTaskFloatingActionButtonState extends State<AddTaskFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        final task = await showDialog<Task?>(
          context: context,
          builder: (context) {
            return TaskDialog();
          },
        );
        if (task != null) {
          // ignore: use_build_context_synchronously
          context.read<TasksBloc>().add(AddTaskEvent(task));
        }
      },
    );
  }
}
