import 'package:db_hotel/db/room_status/room_status_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class RoomStatusDao {
  @insert
  Future<void> insertRoomStatus(RoomStatus roomStatus);

  @Query('SELECT * FROM RoomStatus where name = :name')
  Future<RoomStatus?> getRoomStatusByName(String name);

  @Query('SELECT * FROM RoomStatus where id = :id')
  Future<RoomStatus?> getRoomStatusByID(int id);
}
