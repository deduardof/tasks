import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasks/src/core/constants/app_sizes.dart';
import 'package:tasks/src/core/extensions/context_extensions.dart';

class TaskTypeSelectBottom extends StatelessWidget {
  const TaskTypeSelectBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSizes.defaultPadding,
      children: [
        Text(
          'Que tarefa deseja criar?',
          style: context.textTheme.titleMedium,
        ),
        Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppSizes.defaultPadding),
            child: Wrap(
              spacing: AppSizes.minPadding,
              runSpacing: AppSizes.minPadding,
              children: List.filled(120, TaskTypeItem()),
            ),
          ),
        ),
      ],
    );
  }
}

class TaskTypeItem extends StatelessWidget {
  TaskTypeItem({super.key});
  final labels = <String>['Mercado', 'Tarefa', 'Trabalho', 'Dev', 'Urgente', 'Bug'];
  final colors = <Color>[Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.amber, Colors.cyanAccent];

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        labels[Random().nextInt(6)],
        style: TextStyle(color: Colors.white),
      ),
      avatar: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: SizedBox(
          width: 120,
          height: 120,
          child: ColoredBox(color: colors[Random().nextInt(6)]),
        ),
      ),
    );
    /* Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: SizedBox(
            width: 120,
            height: 120,
            child: ColoredBox(color: colors[Random().nextInt(6)]),
          ),
        ),
        Text(
          labels[Random().nextInt(6)],
          style: TextStyle(color: Colors.white),
        ),
      ],
    ); */
  }
}
