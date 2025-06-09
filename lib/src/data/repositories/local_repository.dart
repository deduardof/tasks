import 'package:tasks/src/models/task.dart';

abstract class LocalRepository {
  // Return a list of all tasks
  Future<List<Task>> getAll();
  // Add a new task
  Future<void> addTask(Task task);
  // Update an existing task
  Future<void> updateTask(Task task);
  // Remove a task
  Future<void> removeTask(Task task);
}
