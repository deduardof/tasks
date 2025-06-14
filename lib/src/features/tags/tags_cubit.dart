import 'package:flutter_bloc/flutter_bloc.dart';

class TagsCubit extends Cubit<List<String>> {
  TagsCubit(super.initialState);

  void add(String tag) {
    if (!state.contains(tag)) {
      state.add(tag);
    }
    emit(List.from(state));
  }

  void addAll(List<String> tags) {
    for (var tag in tags) {
      if (!state.contains(tag)) {
        state.add(tag);
      }
    }
    emit(List.from(state));
  }

  void remove(String tag) {
    state.removeWhere((t) => t == tag);
    emit(List.from(state));
  }
}
