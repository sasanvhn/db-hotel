import 'package:floor/floor.dart';

@entity
class BookingStatus {
  BookingStatus({required this.name});

  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
}

// 'CREATE TABLE IF NOT EXISTS `BookingStatus`
// (`id` INTEGER PRIMARY KEY AUTOINCREMENT,
// `name` TEXT NOT NULL)'
