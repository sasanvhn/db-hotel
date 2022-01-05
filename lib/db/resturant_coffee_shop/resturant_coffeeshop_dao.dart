import 'package:db_hotel/db/resturant_coffee_shop/resturant_coffeeshop_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class RestaurantDao {
  @insert
  Future<void> insertRestaurant(RestaurantCoffeeShop r);

  @Query('SELECT * FROM RestaurantCoffeeShop')
  Future<List<RestaurantCoffeeShop>> getAll();

  @Query('SELECT * FROM RestaurantCoffeeShop where type = :t')
  Future<List<RestaurantCoffeeShop>> getRestaurantsByType(int t);

  @Query('SELECT * FROM RestaurantCoffeeShop where name = :name')
  Future<RestaurantCoffeeShop?> getRestaurantByName(String name);
}
