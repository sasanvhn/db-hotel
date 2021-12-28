import 'package:db_hotel/db/room/room_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class RoomDao {
  @insert
  Future<void> insertRoom(Room room);

  @Query('SELECT * FROM Room')
  Future<Room?> getAllRooms();

  @Query('SELECT * FROM Room where id = :id')
  Future<Room?> getRoomByID(int id);

  @Query('SELECT * FROM Room where status = :statusID')
  Future<Room?> getRoomsByStatusID(int statusID);

  @Query('SELECT * FROM Room where type = :typeID')
  Future<Room?> getRoomsByTypeID(int typeID);

  @Query('SELECT * FROM Room where type = :typeID and status = :statusID')
  Future<Room?> getRoomsByTypeIDAndStatusID(int typeID, int statusID);
}
