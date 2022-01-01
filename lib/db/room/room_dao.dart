import 'package:db_hotel/db/room/room_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class RoomDao {
  @insert
  Future<void> insertRoom(Room room);

  @Query('SELECT * FROM Room')
  Future<List<Room>> getAll();

  @Query('SELECT * FROM Room where id = :id')
  Future<Room?> getRoomByID(int id);

  @Query('SELECT * FROM Room where status = :statusID')
  Future<List<Room?>?> getRoomsByStatusID(int statusID);

  @Query('SELECT * FROM Room where type = :typeID')
  Future<List<Room?>?> getRoomsByTypeID(int typeID);

  @Query('SELECT * FROM Room where type = :typeID and status = :statusID')
  Future<List<Room?>?> getRoomsByTypeIDAndStatusID(int typeID, int statusID);

  @update
  Future<void> updateRoom(Room room);

  @update
  Future<int> updateRooms(List<Room> rooms);
}
