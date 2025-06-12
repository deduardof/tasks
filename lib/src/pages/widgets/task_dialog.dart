import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks/src/core/constants/app_sizes.dart';
import 'package:tasks/src/features/tags/tags_cubit.dart';
import 'package:tasks/src/models/task.dart';

class TaskDialog extends StatefulWidget {
  const TaskDialog({super.key, this.task});
  final Task? task;

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final formKey = GlobalKey<FormState>();
  final tagController = TextEditingController();
  String title = '';
  String description = '';

  @override
  void initState() {
    if (widget.task != null) {
      title = widget.task!.title;
      description = widget.task!.description;
    }
    super.initState();
  }

  @override
  void dispose() {
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              BlocProvider<TagsCubit>(
                create: (context) => TagsCubit([]),
                child: BlocBuilder<TagsCubit, List<String>>(
                  builder: (context, tags) {
                    return Column(
                      children: [
                        TextFormField(
                          controller: tagController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                context.read<TagsCubit>().add(tagController.text.trim());
                                tagController.clear();
                              },
                              icon: Icon(Icons.add),
                            ),
                          ),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppSizes.defaultPadding),
                            child: SizedBox(
                              width: double.maxFinite,
                              child: Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6.0,
                                      horizontal: 4.0,
                                    ),
                                    child: Text('Tags:'),
                                  ),
                                  ...tags.map(
                                    (tag) => TextButton(
                                      onPressed: () {
                                        context.read<TagsCubit>().remove(tag);
                                      },
                                      child: Text(tag),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
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
  }
}
