import 'package:floor/floor.dart';

@entity
class RoomStatus {
  RoomStatus({required this.name});

  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
}

// 'CREATE TABLE IF NOT EXISTS `RoomStatus`
// (`id` INTEGER PRIMARY KEY AUTOINCREMENT,
// `name` TEXT NOT NULL)'