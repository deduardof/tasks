import 'package:isar/isar.dart';
import 'package:tasks/src/models/isar_local_theme.dart';

class IsarThemeRepository {
  final Isar _isar;
  IsarThemeRepository(Isar isar) : _isar = isar;

  Future<void> saveTheme(String themeName) async {
    print('Saving theme: $themeName');
    await _isar.writeTxn(() async {
      await _isar.isarLocalThemes.put(IsarLocalTheme(name: themeName));
    });
  }

  Future<String> loadTheme() async {
    final response = await _isar.isarLocalThemes.where().findFirst();
    return response?.name ?? '';
  }
}
