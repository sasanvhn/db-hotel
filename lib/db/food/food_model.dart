import 'package:db_hotel/db/resturant_coffee_shop/resturant_coffeeshop_model.dart';
import 'package:floor/floor.dart';

@Entity(foreignKeys: [
  ForeignKey(
      childColumns: ['shopId'],
      parentColumns: ['id'],
      entity: RestaurantCoffeeShop,
      onDelete: ForeignKeyAction.cascade),
])
class Food {
  Food(
      {required this.name,
      required this.price,
      required this.shopId,
      required this.type,
      this.ingredients});

  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
  int price;
  int shopId;
  int type; //0:food - 1:drink
  String? ingredients;
}

// 'CREATE TABLE IF NOT EXISTS `Food`
// (`id` INTEGER PRIMARY KEY AUTOINCREMENT,
// `name` TEXT NOT NULL,
// `price` INTEGER NOT NULL,
// `shopId` INTEGER NOT NULL,
// `type` INTEGER NOT NULL,
// `ingredients` TEXT,
// FOREIGN KEY (`shopId`) REFERENCES `RestaurantCoffeeShop` (`id`)
// ON UPDATE NO ACTION ON DELETE CASCADE)');
