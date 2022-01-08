import 'package:db_hotel/db/staff/staff_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class StaffDao {
  @insert
  Future<void> insertStaff(Staff staff);

  @Query('SELECT * FROM Staff where id = :id')
  Future<Staff?> getStaffByID(int id);

  @Query(
      'SELECT * FROM Staff where password = :password and nationalID = :nationalID')
  Future<Staff?> getStaff(String nationalID, String password);
}
