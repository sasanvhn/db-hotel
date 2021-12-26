import 'package:floor/floor.dart';
import 'guest_model.dart';

@dao
abstract class GuestDao {
  @insert
  Future<void> insertGuest(Guest guest);

  @Query(
      'SELECT * FROM Guest where password = :password and nationalID = :nationalID')
  Future<Guest?> getGuest(String nationalID, String password);

  @Query('SELECT * FROM Guest where nationalID = :nationalID')
  Future<Guest?> getGuestByNationalID(String nationalID);
}
