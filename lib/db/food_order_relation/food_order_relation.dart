import 'package:db_hotel/db/food/food_model.dart';
import 'package:db_hotel/db/food_order_relation/food_order_relation_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class FoodOrderDao {
  @insert
  Future<void> insertFoodOrderRelation(FoodOrderRelation foodOrder);

  @Query(
      'SELECT * FROM Food where id = (SELECT food FROM FoodOrderRelation where order = :order)')
  Future<Food?> getFoodsByOrderID(int order);

  @delete
  Future<int> deleteFoodOrderRelations(List<FoodOrderRelation> a);

  @Query('SELECT * FROM FoodOrderRelation')
  Future<List<FoodOrderRelation>> getAll();

  @Query('SELECT * FROM FoodOrderRelation where "order" = :a')
  Future<List<FoodOrderRelation>> getFoodOrderRelationByOrderID(int a);
}
