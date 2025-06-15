import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/src/core/constants/app_sizes.dart';
import 'package:tasks/src/core/extensions/context_extensions.dart';
import 'package:tasks/src/features/tasks/tasks_bloc.dart';
import 'package:tasks/src/features/tasks/tasks_event.dart';
import 'package:tasks/src/models/task.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task,
    required this.onTap,
  });
  final Task task;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.primaryContainer,
          borderRadius: BorderRadius.circular(
            AppSizes.defaultRadius,
          ),
        ),
        child: Row(
          children: [
            Checkbox(
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: .0,
                  top: 8.0,
                  right: 16.0,
                  bottom: 8.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.colors.onErrorContainer,
                        ),
                      ),
                    ),
                    if (task.description.isNotEmpty)
                      Flexible(
                        child: Text(
                          task.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colors.onErrorContainer,
                          ),
                        ),
                      ),
                    Wrap(
                      children: task.tags
                          .map(
                            (tag) => Padding(
                              padding: const EdgeInsets.only(right: AppSizes.minPadding),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: context.colors.secondaryContainer,
                                  borderRadius: BorderRadius.circular(AppSizes.minRadius),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    tag,
                                    style: context.textTheme.labelSmall?.copyWith(
                                      color: context.colors.onSecondaryContainer,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
