import 'package:db_hotel/db/booking_status/booking_status_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class BookingStatusDao {
  @insert
  Future<void> insertBookingStatus(BookingStatus roomStatus);

  @Query('SELECT * FROM BookingStatus where name = :name')
  Future<BookingStatus?> getBookingStatusByName(String name);

  @Query('SELECT * FROM BookingStatus where id = :id')
  Future<BookingStatus?> getBookingStatusByID(int id);
}
