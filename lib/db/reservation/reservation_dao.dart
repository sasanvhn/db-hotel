import 'package:db_hotel/db/reservation/reservation_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class ReservationDao {
  @insert
  Future<int> insertReservation(Reservation reservation);

  @Query(
      'SELECT * FROM Reservation where guest = :guestID and reserveDate = :reserveDate and checkInDate = :checkInDate and noNights = :noNights')
  Future<Reservation?> getReservationByDetails(
      int guestID, String reserveDate, String checkInDate, int noNights);

  @update
  Future<void> updateReservation(Reservation reservation);

  @Query('SELECT * FROM Reservation where id = :id')
  Future<Reservation?> getReservationByID(int id);

  @Query('SELECT * FROM Reservation')
  Future<List<Reservation>?> getAll();

  @delete
  Future<void> deleteReservation(Reservation reservation);

  @delete
  Future<int> deleteReservations(List<Reservation> reservations);

  @Query('SELECT * FROM Reservation where guest = :id')
  Future<List<Reservation>> getReservationByGuestID(int id);

  @Query(
      'SELECT * FROM Reservation where guest = :id and bookingStatus = :status')
  Future<List<Reservation>> getReservationByGuestIDAndStatus(
      int id, int status);
}
