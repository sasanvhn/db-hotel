import 'package:floor/floor.dart';

@entity
class RestaurantCoffeeShop {
  RestaurantCoffeeShop({this.id, required this.name, required this.type});

  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
  int type; //0: restaurant - 1: coffee shop
}

// 'CREATE TABLE IF NOT EXISTS `RestaurantCoffeeShop`
// (`id` INTEGER PRIMARY KEY AUTOINCREMENT,
// `name` TEXT NOT NULL,
// `type` INTEGER NOT NULL)'
