import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/src/data/repositories/local_repository.dart';
import 'package:tasks/src/features/tasks/tasks_event.dart';
import 'package:tasks/src/features/tasks/tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final LocalRepository _localRepository;

  TasksBloc(LocalRepository localRepository) : _localRepository = localRepository, super(InitialTasksState()) {
    on<LoadTasksEvent>((event, emit) async {
      final tasks = await _localRepository.getAll();
      emit(SuccessTasksState(tasks));
    });

    on<AddTaskEvent>((event, emit) async {
      final task = event.task;
      await _localRepository.addTask(task);
      final tasks = await _localRepository.getAll();
      emit(SuccessTasksState(tasks));
    });

    on<UpdateTaskEvent>((event, emit) async {
      final task = event.task;
      await _localRepository.updateTask(task);
      final tasks = await _localRepository.getAll();
      emit(SuccessTasksState(tasks));
    });

    on<ToggleTaskEvent>((event, emit) async {
      final task = event.task;
      await _localRepository.updateTask(task.toggle());
      final tasks = await _localRepository.getAll();
      emit(SuccessTasksState(tasks));
    });

    on<RemoveTaskEvent>((event, emit) async {
      final task = event.task;
      await _localRepository.removeTask(task);
      final tasks = await _localRepository.getAll();
      emit(SuccessTasksState(tasks));
    });
  }
}
