import 'package:db_hotel/db/reservation_details/reservation_details_model.dart';
import 'package:floor/floor.dart';

@Entity(foreignKeys: [
  ForeignKey(
      childColumns: ["reservationDetail"],
      parentColumns: ["id"],
      entity: ReservationDetails)
])
class Order {
  Order({this.id, required this.place, required this.reservationDetail});

  @PrimaryKey(autoGenerate: true)
  int? id;
  int place; //0:room - 1:restaurant
  int reservationDetail;
}

// 'CREATE TABLE IF NOT EXISTS `Order`
// (`id` INTEGER PRIMARY KEY AUTOINCREMENT,
// `place` INTEGER NOT NULL,
// `reservationDetail` INTEGER NOT NULL,
// FOREIGN KEY (`reservationDetail`) REFERENCES `ReservationDetails` (`id`)
// ON UPDATE NO ACTION ON DELETE NO ACTION)'
