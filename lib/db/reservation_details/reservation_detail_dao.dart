import 'package:db_hotel/db/reservation_details/reservation_details_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class ReservationDetailDao {
  @insert
  Future<void> insertReservationDetail(ReservationDetails reservationDetail);

  @Query('SELECT * FROM ReservationDetails')
  Future<List<ReservationDetails>?> getAll();

  @delete
  Future<void> deleteReservationDetail(ReservationDetails reservationDetails);

  @delete
  Future<int> deleteReservationDetails(
      List<ReservationDetails> reservationDetails);

  @Query(
      'SELECT * FROM ReservationDetails where reservation = :res AND room = :room')
  Future<ReservationDetails?> getReservationDetailByResAndRoom(
      int res, int room);
}
