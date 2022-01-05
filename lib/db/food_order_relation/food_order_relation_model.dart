import 'package:floor/floor.dart';
import '../food/food_model.dart';
import '../order/order_model.dart';

@Entity(foreignKeys: [
  ForeignKey(childColumns: ["food"], parentColumns: ["id"], entity: Food),
  ForeignKey(
      childColumns: ["order"],
      parentColumns: ["id"],
      entity: Order,
      onDelete: ForeignKeyAction.cascade),
])
class FoodOrderRelation {
  FoodOrderRelation({this.id, required this.food, required this.order});

  @PrimaryKey(autoGenerate: true)
  int? id;
  int food;
  int order;
}

// 'CREATE TABLE IF NOT EXISTS `FoodOrderRelation`
// (`id` INTEGER PRIMARY KEY AUTOINCREMENT,
// `food` INTEGER NOT NULL,
// `order` INTEGER NOT NULL,
// FOREIGN KEY (`food`) REFERENCES `Food` (`id`)
// ON UPDATE NO ACTION ON DELETE NO ACTION,
// FOREIGN KEY (`order`) REFERENCES `Order` (`id`)
// ON UPDATE NO ACTION ON DELETE NO ACTION)'
