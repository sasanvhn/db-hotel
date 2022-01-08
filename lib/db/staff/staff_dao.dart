import 'package:db_hotel/db/staff/staff_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class StaffDao {
  @insert
  Future<void> insertStaff(Staff staff);

  @Query('SELECT * FROM Staff where id = :id')
  Future<Staff?> getStaffByID(int id);

  @Query('SELECT * FROM Staff where nationalId = :id')
  Future<Staff?> getStaffByNationalID(String id);

  @Query(
      'SELECT * FROM Staff where password = :password and nationalID = :nationalID')
  Future<Staff?> getStaff(String nationalID, String password);

  @Query('SELECT * FROM Staff where role = 1')
  Future<List<Staff>> getCleaningStaff();

  @Query('SELECT * FROM Staff')
  Future<List<Staff>> getAll();

  @Query('SELECT * FROM Staff where role = 0')
  Future<List<Staff>> getReceptions();

  @delete
  Future<int> deleteStaff(List<Staff> sd);
}
