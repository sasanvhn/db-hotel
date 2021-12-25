import 'package:db_hotel/db/bill/bill_model.dart';
import 'package:db_hotel/db/booking_status/booking_status_model.dart';
import 'package:db_hotel/db/guest/guest_model.dart';
import 'package:db_hotel/db/people/people_model.dart';
import 'package:db_hotel/db/staff/staff_model.dart';
import 'package:floor/floor.dart';

@Entity(foreignKeys: [
  ForeignKey(
      childColumns: ["bookingStatus"],
      parentColumns: ["id"],
      entity: BookingStatus),
  ForeignKey(childColumns: ["staff"], parentColumns: ["id"], entity: Staff),
  ForeignKey(childColumns: ["guest"], parentColumns: ["id"], entity: Guest),
  ForeignKey(childColumns: ["bill"], parentColumns: ["id"], entity: Bill),
  ForeignKey(childColumns: ["people"], parentColumns: ["id"], entity: People),
])
class Reservation {
  Reservation(
      {required this.people,
      required this.reserveDate,
      this.checkInDate,
      this.checkOutDate,
      this.noNights,
      required this.bookingStatus,
      required this.staff,
      this.guest,
      this.bill});

  @PrimaryKey(autoGenerate: true)
  int? id;
  String reserveDate;
  String? checkInDate;
  String? checkOutDate;
  int? noNights;
  int bookingStatus;
  int staff;
  int? guest;
  int? bill;
  int people;
}

// 'CREATE TABLE IF NOT EXISTS `Reservation`
// (`id` INTEGER PRIMARY KEY AUTOINCREMENT,
// `reserveDate` TEXT NOT NULL,
// `checkInDate` TEXT, `checkOutDate` TEXT,
// `noNights` INTEGER, `bookingStatus` INTEGER NOT NULL,
// `staff` INTEGER NOT NULL,
// `guest` INTEGER, `bill` INTEGER,
// `people` INTEGER NOT NULL,
// FOREIGN KEY (`bookingStatus`) REFERENCES `BookingStatus` (`id`)
// ON UPDATE NO ACTION ON DELETE NO ACTION,
// FOREIGN KEY (`staff`) REFERENCES `Staff` (`id`)
// ON UPDATE NO ACTION ON DELETE NO ACTION,
// FOREIGN KEY (`guest`) REFERENCES `Guest` (`id`)
// ON UPDATE NO ACTION ON DELETE NO ACTION,
// FOREIGN KEY (`bill`) REFERENCES `Bill` (`id`)
// ON UPDATE NO ACTION ON DELETE NO ACTION,
// FOREIGN KEY (`people`) REFERENCES `People` (`id`)
// ON UPDATE NO ACTION ON DELETE NO ACTION)'
