import 'package:isar/isar.dart';
import 'package:tasks/src/data/repositories/local_repository.dart';
import 'package:tasks/src/models/task.dart';

class IsarLocalRepository extends LocalRepository {
  final Isar _isar;

  IsarLocalRepository(Isar isar) : _isar = isar;

  @override
  Future<List<Task>> getAll() async {
    final tasks = await _isar.tasks.where().findAll();
    return tasks;
  }

  @override
  Future<void> addTask(Task task) async {
    await _isar.writeTxn(
      () async {
        await _isar.tasks.put(task);
      },
    );
  }

  @override
  Future<void> removeTask(Task task) async {
    await _isar.writeTxn(
      () async {
        await _isar.tasks.delete(task.id);
      },
    );
  }

  @override
  Future<void> updateTask(Task task) async {
    await _isar.writeTxn(
      () async {
        await _isar.tasks.put(task);
      },
    );
  }
}
