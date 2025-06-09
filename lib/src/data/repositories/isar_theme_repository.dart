import 'package:isar/isar.dart';
import 'package:tasks/src/models/isar_local_theme.dart';

class IsarThemeRepository {
  final Isar _isar;
  IsarThemeRepository(String dir)
    : _isar = Isar.openSync(
        [IsarLocalThemeSchema],
        directory: dir,
      );

  Future<void> saveTheme(String themeName) async {
    print('Saving theme: $themeName');
    await _isar.writeTxn(() async {
      await _isar.isarLocalThemes.put(IsarLocalTheme(id: 0, name: themeName));
    });
  }

  Future<String> loadTheme() async {
    final response = await _isar.isarLocalThemes.where().findFirst();
    return response?.name ?? '';
  }
}
