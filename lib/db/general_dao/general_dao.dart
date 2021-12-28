import 'package:floor/floor.dart';

@dao
abstract class GeneralDao {
  @Query('DELETE * FROM RoomStatus, RoomType, Room, Guest')
  Future<void> deleteSome();
}
