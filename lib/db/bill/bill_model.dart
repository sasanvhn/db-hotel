import 'package:floor/floor.dart';

@entity
class Bill {
  Bill({required this.total, this.status = 1});

  @PrimaryKey(autoGenerate: true)
  int? id;
  int total;
  int status;
}


// 'CREATE TABLE IF NOT EXISTS `Bill`
// (`id` INTEGER PRIMARY KEY AUTOINCREMENT,
// `total` INTEGER NOT NULL,
// `status` INTEGER NOT NULL)'