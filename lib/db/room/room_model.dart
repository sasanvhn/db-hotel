import 'package:db_hotel/db/room_status/room_status_model.dart';
import 'package:db_hotel/db/room_type/room_type_model.dart';
import 'package:floor/floor.dart';

@Entity(foreignKeys: [
  ForeignKey(
      childColumns: ['type'],
      parentColumns: ['id'],
      entity: RoomType,
      onDelete: ForeignKeyAction.cascade),
  ForeignKey(
      childColumns: ['status'],
      parentColumns: ['id'],
      entity: RoomStatus,
      onDelete: ForeignKeyAction.cascade),
])
class Room {
  Room(
      {required this.number,
      required this.floor,
      required this.price,
      this.capacity = 3,
      required this.type,
      required this.status});

  @PrimaryKey(autoGenerate: true)
  int? id;
  int number;
  int floor;
  int price;
  int capacity;
  int type;
  int status;
}

//'CREATE TABLE IF NOT EXISTS `Room`
// (`id` INTEGER PRIMARY KEY AUTOINCREMENT,
// `number` INTEGER NOT NULL,
// `floor` INTEGER NOT NULL,
// `price` INTEGER NOT NULL,
// `capacity` INTEGER NOT NULL,
// `type` INTEGER NOT NULL,
// `status` INTEGER NOT NULL,
// FOREIGN KEY (`type`) REFERENCES `RoomType` (`id`)
// ON UPDATE NO ACTION ON DELETE CASCADE,
// FOREIGN KEY (`status`) REFERENCES `RoomStatus` (`id`)
// ON UPDATE NO ACTION ON DELETE CASCADE)'
