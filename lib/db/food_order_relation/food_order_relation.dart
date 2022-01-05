import 'package:db_hotel/db/food_order_relation/food_order_relation_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class FoodOrderDao {
  @insert
  Future<void> insertFoodOrderRelation(FoodOrderRelation foodOrder);

  @Query(
      'SELECT * FROM Food where id in (SELECT food FROM FoodOrderRelation where order = :order)')
  Future<List<FoodOrderRelation>> getFoodsByOrderID(int order);
}
