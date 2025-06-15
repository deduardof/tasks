import 'package:flutter/material.dart';
import 'package:tasks/src/core/constants/app_sizes.dart';
import 'package:tasks/src/pages/task_type_select_bottom.dart';

class TaskTypesPage extends StatelessWidget {
  const TaskTypesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Qual tarefa deseja criar?'),
          SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(AppSizes.defaultPadding),
            child: Wrap(
              spacing: AppSizes.minPadding,
              runSpacing: AppSizes.minPadding,
              children: List.filled(120, TaskTypeItem()),
            ),
          ),
        ],
      ),
    );
  }
}
