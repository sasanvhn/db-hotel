import 'package:db_hotel/db/order/order_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class OrderDao {
  @insert
  Future<void> insertOrder(Order r);

  @Query('SELECT * FROM Order where reservationDetail = :rd')
  Future<List<Order>> getOrdersByReservationDetailID(int rd);
}
