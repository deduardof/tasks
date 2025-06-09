import 'package:tasks/src/models/task.dart';

sealed class TasksEvent {}

class AddTaskEvent extends TasksEvent {
  final Task task;
  AddTaskEvent(this.task);
}

class LoadTasksEvent extends TasksEvent {}

class ToggleTaskEvent extends TasksEvent {
  final Task task;
  ToggleTaskEvent(this.task);
}

class UpdateTaskEvent extends TasksEvent {
  final Task task;
  UpdateTaskEvent(this.task);
}

class RemoveTaskEvent extends TasksEvent {
  final Task task;
  RemoveTaskEvent(this.task);
}
