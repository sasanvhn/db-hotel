import 'dart:async';
import 'package:db_hotel/db/bill/bill_model.dart';
import 'package:db_hotel/db/booking_status/booking_status_model.dart';
import 'package:db_hotel/db/food/food_model.dart';
import 'package:db_hotel/db/food_order_relation/food_order_relation_model.dart';
import 'package:db_hotel/db/guest/guest_model.dart';
import 'package:db_hotel/db/order/order_model.dart';
import 'package:db_hotel/db/people/people_model.dart';
import 'package:db_hotel/db/reservation/reservation_model.dart';
import 'package:db_hotel/db/reservation_details/reservation_details_model.dart';
import 'package:db_hotel/db/resturant_coffee_shop/resturant_coffeeshop_model.dart';
import 'package:db_hotel/db/room/room_model.dart';
import 'package:db_hotel/db/room_status/room_status_model.dart';
import 'package:db_hotel/db/room_type/room_type_model.dart';
import 'package:db_hotel/db/staff/staff_model.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [
  People,
  Bill,
  BookingStatus,
  Guest,
  RestaurantCoffeeShop,
  RoomStatus,
  RoomType,
  Staff,
  Food,
  Room,
  Order,
  FoodOrderRelation,
  Reservation,
  ReservationDetails
])
abstract class AppDatabase extends FloorDatabase {
  // PersonDao get personDao;
}
