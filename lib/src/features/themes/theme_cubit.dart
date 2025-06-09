import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/src/data/repositories/isar_theme_repository.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(IsarThemeRepository themeRepository) : _themeRepository = themeRepository, super(ThemeMode.system);
  final IsarThemeRepository _themeRepository;

  Future<void> toggleTheme() async {
    final newTheme = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await _themeRepository.saveTheme(newTheme.name);

    emit(newTheme);
  }

  Future<void> loadTheme() async {
    final themeName = await _themeRepository.loadTheme();
    switch (themeName) {
      case 'light':
        emit(ThemeMode.light);
        break;
      case 'dark':
        emit(ThemeMode.dark);
        break;
      default:
        emit(ThemeMode.system);
        break;
    }
  }
}
