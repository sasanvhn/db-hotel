import 'package:db_hotel/db/order/order_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class OrderDao {
  @insert
  Future<int> insertOrder(Order r);

  // @Query('SELECT * FROM Order')
  // Future<List<Order>> getAll();
}
