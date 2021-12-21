import 'package:floor/floor.dart';

@entity
class Order {
  Order({required this.place});

  @PrimaryKey(autoGenerate: true)
  int? id;
  int place; //0:room - 1:restaurant

}

// 'CREATE TABLE IF NOT EXISTS `Order`
// (`id` INTEGER PRIMARY KEY AUTOINCREMENT,
// `place` INTEGER NOT NULL)'
