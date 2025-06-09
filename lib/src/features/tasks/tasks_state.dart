import 'package:tasks/src/models/task.dart';

sealed class TasksState {
  final List<Task> tasks;
  TasksState(this.tasks);
}

class InitialTasksState extends TasksState {
  InitialTasksState() : super([]);
}

class SuccessTasksState extends TasksState {
  SuccessTasksState(super.tasks);
}

class FailureTasksState extends TasksState {
  FailureTasksState() : super([]);
}
