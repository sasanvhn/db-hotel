import 'package:db_hotel/db/reservation/reservation_model.dart';
import 'package:floor/floor.dart';

@Entity(foreignKeys: [
  ForeignKey(
      childColumns: ["reservation"], parentColumns: ["id"], entity: Reservation)
])
class Bill {
  Bill(
      {this.id,
      required this.total,
      this.status = 1,
      required this.reservation});

  @PrimaryKey(autoGenerate: true)
  int? id;
  int total;
  int status;
  int reservation;
}

// 'CREATE TABLE IF NOT EXISTS `Bill`
// (`id` INTEGER PRIMARY KEY AUTOINCREMENT,
// `total` INTEGER NOT NULL,
// `status` INTEGER NOT NULL)'
