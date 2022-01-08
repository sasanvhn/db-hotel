import 'package:db_hotel/db/room_type/room_type_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class RoomTypeDao {
  @insert
  Future<void> insertRoomType(RoomType roomType);

  @Query('SELECT * FROM RoomType where name = :name')
  Future<RoomType?> getRoomTypeByName(String name);

  @Query('SELECT * FROM RoomType where id = :id')
  Future<RoomType?> getRoomTypeByID(int id);
}
