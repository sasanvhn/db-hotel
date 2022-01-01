import 'dart:developer';

import 'package:db_hotel/configs.dart';
import 'package:db_hotel/db/booking_status/booking_status_model.dart';
import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/reservation/reservation_model.dart';
import 'package:db_hotel/db/reservation_details/reservation_details_model.dart';
import 'package:db_hotel/db/room/room_model.dart';
import 'package:db_hotel/db/room_status/room_status_model.dart';
import 'package:db_hotel/widgets/styles/my_styles.dart';
import 'package:flutter/material.dart';

class Reserve extends StatelessWidget {
  Reserve(
      {Key? key,
      required this.database,
      required this.roomID,
      required this.callback})
      : super(key: key);

  final AppDatabase database;
  final int roomID;
  final Function callback;

  final TextEditingController reserveDateController = TextEditingController();
  final TextEditingController numOfNightsController = TextEditingController();
  final TextEditingController checkInDateController = TextEditingController();
  final TextEditingController checkOutDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reserve Date",
                    style: MyStyles.normalText20,
                  ),
                  TextField(controller: reserveDateController),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Number of Nights",
                    style: MyStyles.normalText20,
                  ),
                  TextField(controller: numOfNightsController),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Check in Date",
                    style: MyStyles.normalText20,
                  ),
                  TextField(controller: checkInDateController),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Check out Date",
                    style: MyStyles.normalText20,
                  ),
                  TextField(controller: checkOutDateController),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    if (reserveDateController.text != "" &&
                        numOfNightsController.text != "") {
                      _reserve(context, roomID, callback);
                    } else {
                      log("pass or name is empty", name: "LOGIN");
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 80,
                    decoration: MyStyles.roundedBox,
                    child: const Center(
                      child: Text("Reserve"),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _reserve(context, int roomid, Function callback) async {
    BookingStatus? bookingStatusWaiting =
        await database.bookingStatusDao.getBookingStatusByName("Waiting");
    log(
        "guest: ${Configs.guest!.id}, resDate: ${reserveDateController.text},"
        " bookstat: ${bookingStatusWaiting!.id}, checkin: "
        "${checkInDateController.text}, checkout: "
        "${checkOutDateController.text}, numNight: ${numOfNightsController.text}",
        name: "RESERVE");

    Room? room = await database.roomDao.getRoomByID(roomid);
    RoomStatus? fullStatus =
        await database.roomStatusDao.getRoomStatusByName("Full");
    room!.status = fullStatus!.id!;
    await database.roomDao.updateRoom(room);

    Reservation? res = await database.reservationDao.getReservationByDetails(
        Configs.guest!.id!,
        reserveDateController.text,
        checkInDateController.text,
        int.parse(numOfNightsController.text));

    if (res == null) {
      log("creating reservation", name: "RESERVE");
      res = Reservation(
        guest: Configs.guest!.id!,
        reserveDate: reserveDateController.text,
        bookingStatus: bookingStatusWaiting.id!,
        checkInDate: checkInDateController.text,
        checkOutDate: checkOutDateController.text,
        noNights: int.parse(numOfNightsController.text),
      );

      final int resID = await database.reservationDao.insertReservation(res);

      ReservationDetails resD =
          ReservationDetails(room: roomid, reservation: resID);

      await database.reservationDetailDao.insertReservationDetail(resD);

      log("reserve successful", name: "RESERVE");
    } else {
      log("reservation found, adding to it", name: "RESERVE");
      ReservationDetails resD =
          ReservationDetails(room: roomid, reservation: res.id!);

      await database.reservationDetailDao.insertReservationDetail(resD);

      res.bookingStatus = bookingStatusWaiting.id!;
      database.reservationDao.updateReservation(res);

      final Reservation? checkRes =
          await database.reservationDao.getReservationByID(res.id!);

      log("reserve status: ${checkRes!.bookingStatus}", name: "RESERVE");
      log("reserve successful", name: "RESERVE");
    }

    callback();
    Navigator.pop(context);
  }
}
