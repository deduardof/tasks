// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:isar/isar.dart';

part 'isar_local_theme.g.dart';

@collection
class IsarLocalTheme {
  final Id id;
  final String name;

  IsarLocalTheme({
    this.id = Isar.autoIncrement,
    required this.name,
  });
}
