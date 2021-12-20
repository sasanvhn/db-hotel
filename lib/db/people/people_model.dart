import 'package:floor/floor.dart';

@entity
class People {
  People({required this.name, this.gender, required this.nationalId});

  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
  String? gender;
  String nationalId;
}

// 'CREATE TABLE IF NOT EXISTS `People`
// (`id` INTEGER PRIMARY KEY AUTOINCREMENT,
// `name` TEXT NOT NULL,
// `gender` TEXT,
// `nationalId` TEXT NOT NULL)
