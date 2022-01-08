import 'package:db_hotel/db/food/food_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class FoodDao {
  @insert
  Future<void> insertFood(Food f);

  @Query('SELECT * FROM Food where shopId = :shopID')
  Future<List<Food>> getFoodByShopID(int shopID);

  @Query('SELECT * FROM Food where shopId = :shopID AND type= :t')
  Future<List<Food>> getFoodByShopIDAndType(int shopID, int t);

  @Query('SELECT * FROM Food')
  Future<List<Food>> getAll();

  @Query('SELECT * FROM Food where id = :id')
  Future<Food?> getFoodByID(int id);

  @delete
  Future<int> deleteFoods(List<Food> f);
}
