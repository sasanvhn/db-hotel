import 'dart:developer';

import 'package:db_hotel/configs.dart';
import 'package:db_hotel/db/booking_status/booking_status_model.dart';
import 'package:db_hotel/db/cleaning_service/cleaning_service_model.dart';
import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/people/people_model.dart';
import 'package:db_hotel/db/reservation/reservation_model.dart';
import 'package:db_hotel/db/reservation_details/reservation_details_model.dart';
import 'package:db_hotel/db/room/room_model.dart';
import 'package:db_hotel/db/room_status/room_status_model.dart';
import 'package:db_hotel/widgets/styles/my_styles.dart';
import 'package:flutter/material.dart';

class AddPeople extends StatelessWidget {
  AddPeople({Key? key, required this.database, required this.reservationID})
      : super(key: key);

  final AppDatabase database;
  final int reservationID;

  final TextEditingController peopleNameController = TextEditingController();
  final TextEditingController peopleIDController = TextEditingController();
  final TextEditingController peopleGenderController = TextEditingController();

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
                    "National Code",
                    style: MyStyles.normalText20,
                  ),
                  TextField(controller: peopleIDController),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: MyStyles.normalText20,
                  ),
                  TextField(controller: peopleNameController),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Gender",
                    style: MyStyles.normalText20,
                  ),
                  TextField(controller: peopleGenderController),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    if (peopleNameController.text != "" &&
                        peopleIDController.text != "") {
                      _add(context, reservationID);
                    } else {
                      log("name or ID is empty", name: "ADD GUEST");
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 80,
                    decoration: MyStyles.roundedBox,
                    child: const Center(
                      child: Text("Add"),
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

  void _add(context, int reservationID) async {
    People p = People(
        name: peopleNameController.text,
        nationalId: peopleIDController.text,
        gender: peopleGenderController.text);

    await database.peopleDao.insertGuest(p);

    log("Added Guest", name: "ADD GUEST");

    Navigator.pop(context);
  }
}
