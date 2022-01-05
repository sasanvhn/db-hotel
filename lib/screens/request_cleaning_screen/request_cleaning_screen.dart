import 'dart:developer';

import 'package:db_hotel/configs.dart';
import 'package:db_hotel/db/booking_status/booking_status_model.dart';
import 'package:db_hotel/db/cleaning_service/cleaning_service_model.dart';
import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/reservation/reservation_model.dart';
import 'package:db_hotel/db/reservation_details/reservation_details_model.dart';
import 'package:db_hotel/db/room/room_model.dart';
import 'package:db_hotel/db/room_status/room_status_model.dart';
import 'package:db_hotel/widgets/styles/my_styles.dart';
import 'package:flutter/material.dart';

class RequestCleaning extends StatelessWidget {
  RequestCleaning(
      {Key? key,
      required this.database,
      required this.roomID,
      required this.reservationID})
      : super(key: key);

  final AppDatabase database;
  final int roomID;
  final int reservationID;

  final TextEditingController cleaningDateController = TextEditingController();
  final TextEditingController cleaningTimeController = TextEditingController();

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
                    "Cleaning Date",
                    style: MyStyles.normalText20,
                  ),
                  TextField(controller: cleaningDateController),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cleaning Time",
                    style: MyStyles.normalText20,
                  ),
                  TextField(controller: cleaningTimeController),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    if (cleaningTimeController.text != "" &&
                        cleaningDateController.text != "") {
                      _req(context, roomID, reservationID);
                    } else {
                      log("time or date is empty", name: "LOGIN");
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 80,
                    decoration: MyStyles.roundedBox,
                    child: const Center(
                      child: Text("Request"),
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

  void _req(context, int roomid, int reservationID) async {
    ReservationDetails? rd = await database.reservationDetailDao
        .getReservationDetailByResAndRoom(reservationID, roomid);

    log("found rd: ${rd!.id!}", name: "REQUEST CLEAN");

    CleaningServiceModel cs = CleaningServiceModel(
        reservationDetail: rd.id!,
        date: cleaningDateController.text,
        time: cleaningTimeController.text);
    await database.cleaningServiceDao.insertCleaningService(cs);

    log("Added cs", name: "REQUEST CLEAN");

    Navigator.pop(context);
  }
}
