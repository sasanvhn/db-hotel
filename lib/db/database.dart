import 'dart:async';
import 'package:db_hotel/db/bill/bill_model.dart';
import 'package:db_hotel/db/booking_status/booking_status_dao.dart';
import 'package:db_hotel/db/booking_status/booking_status_model.dart';
import 'package:db_hotel/db/cleaning_service/cleaning_service_dao.dart';
import 'package:db_hotel/db/cleaning_service/cleaning_service_model.dart';
import 'package:db_hotel/db/food/food_model.dart';
import 'package:db_hotel/db/food_order_relation/food_order_relation_model.dart';
import 'package:db_hotel/db/general_dao/general_dao.dart';
import 'package:db_hotel/db/guest/guest_dao.dart';
import 'package:db_hotel/db/guest/guest_model.dart';
import 'package:db_hotel/db/order/order_model.dart';
import 'package:db_hotel/db/people/people_dao.dart';
import 'package:db_hotel/db/people/people_model.dart';
import 'package:db_hotel/db/reservation/reservation_dao.dart';
import 'package:db_hotel/db/reservation/reservation_model.dart';
import 'package:db_hotel/db/reservation_details/reservation_detail_dao.dart';
import 'package:db_hotel/db/reservation_details/reservation_details_model.dart';
import 'package:db_hotel/db/resturant_coffee_shop/resturant_coffeeshop_model.dart';
import 'package:db_hotel/db/room/room_dao.dart';
import 'package:db_hotel/db/room/room_model.dart';
import 'package:db_hotel/db/room_status/room_status_dao.dart';
import 'package:db_hotel/db/room_status/room_status_model.dart';
import 'package:db_hotel/db/room_type/room_type_dao.dart';
import 'package:db_hotel/db/room_type/room_type_model.dart';
import 'package:db_hotel/db/staff/staff_dao.dart';
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
  ReservationDetails,
  CleaningServiceModel
])
abstract class AppDatabase extends FloorDatabase {
  // PersonDao get personDao;
  GuestDao get guestDao;
  RoomTypeDao get roomTypeDao;
  RoomStatusDao get roomStatusDao;
  RoomDao get roomDao;
  GeneralDao get generalDao;
  BookingStatusDao get bookingStatusDao;
  ReservationDao get reservationDao;
  StaffDao get staffDao;
  ReservationDetailDao get reservationDetailDao;
  CleaningServiceDao get cleaningServiceDao;
  PeopleDao get peopleDao;
}
