import 'package:db_hotel/db/reservation_details/reservation_details_model.dart';
import 'package:db_hotel/db/staff/staff_model.dart';
import 'package:floor/floor.dart';

@Entity(foreignKeys: [
  ForeignKey(childColumns: ["staff"], parentColumns: ["id"], entity: Staff),
  ForeignKey(
      childColumns: ["reservationDetail"],
      parentColumns: ["id"],
      entity: ReservationDetails),
])
class CleaningServiceModel {
  CleaningServiceModel(
      {required this.reservationDetail,
      required this.date,
      this.time,
      this.staff,
      this.description});

  @PrimaryKey(autoGenerate: true)
  int? id;
  String date;
  String? time;
  String? description;
  int? staff;
  int reservationDetail;
}

// 'CREATE TABLE IF NOT EXISTS `CleaningServiceModel`
// (`id` INTEGER PRIMARY KEY AUTOINCREMENT,
// `date` TEXT NOT NULL,
// `time` TEXT, `description` TEXT, `staff` INTEGER,
// `reservationDetail` INTEGER NOT NULL,
// FOREIGN KEY (`staff`) REFERENCES `Staff` (`id`)
// ON UPDATE NO ACTION ON DELETE NO ACTION,
// FOREIGN KEY (`reservationDetail`) REFERENCES `ReservationDetails`
// (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)'
