import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasks/src/models/task.dart';

sealed class LocalRepository {
  Future<List<Task>> getAll();
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> removeTask(Task task);
}

class IsarLocalRepository extends LocalRepository {
  late final Isar _isar;

  IsarLocalRepository() {
    _open();
  }

  Future<void> _open() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [TaskSchema],
      directory: dir.path,
    );
  }

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
