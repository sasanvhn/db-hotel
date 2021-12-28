import 'package:db_hotel/db/room/room_model.dart';
import 'package:floor/floor.dart';

@Entity(foreignKeys: [
  ForeignKey(childColumns: ["room"], parentColumns: ["id"], entity: Room),
])
class ReservationDetails {
  ReservationDetails(
      {this.id,
      required this.room,
      required this.reservation,
      this.rate,
      this.extraFacilities});

  @PrimaryKey(autoGenerate: true)
  int? id;
  int? rate;
  String? extraFacilities;
  int room;
  int reservation;
}

// 'CREATE TABLE IF NOT EXISTS `ReservationDetails`
// (`id` INTEGER PRIMARY KEY AUTOINCREMENT,
// `rate` INTEGER, `extraFacilities` TEXT,
// `room` INTEGER NOT NULL,
// `reservation` INTEGER NOT NULL,
// FOREIGN KEY (`room`) REFERENCES `Room` (`id`)
// ON UPDATE NO ACTION ON DELETE NO ACTION)');
