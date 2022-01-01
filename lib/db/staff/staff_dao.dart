import 'package:db_hotel/db/staff/staff_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class StaffDao {
  @insert
  Future<void> insertStaff(Staff staff);

  @Query('SELECT * FROM Staff where id = :id')
  Future<Staff?> getStaffByID(int id);
}
