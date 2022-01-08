import 'dart:developer';

import 'package:db_hotel/configs.dart';
import 'package:db_hotel/db/booking_status/booking_status_model.dart';
import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/reservation/reservation_model.dart';
import 'package:db_hotel/db/reservation_details/reservation_details_model.dart';
import 'package:db_hotel/db/room/room_model.dart';
import 'package:db_hotel/db/room_status/room_status_model.dart';
import 'package:db_hotel/db/staff/staff_model.dart';
import 'package:db_hotel/widgets/styles/my_styles.dart';
import 'package:flutter/material.dart';

class AddStaffScreen extends StatelessWidget {
  AddStaffScreen({Key? key, required this.database, required this.callback})
      : super(key: key);

  final AppDatabase database;
  final Function callback;

  final TextEditingController signupNameController = TextEditingController();
  final TextEditingController signupPassController = TextEditingController();
  final TextEditingController signupIDController = TextEditingController();
  final TextEditingController signupGenderController = TextEditingController();
  final TextEditingController signupAddressController = TextEditingController();
  final TextEditingController signupBirthDateController =
      TextEditingController();
  final TextEditingController signupPhoneController = TextEditingController();

  void _signup(context) async {
    log(
        "name: ${signupNameController.text} and pass: ${signupPassController.text} and "
        "nationalID: ${signupIDController.text} and address ${signupAddressController.text}"
        " and gender: ${signupGenderController.text} and phone: ${signupPhoneController.text}"
        " and birth: ${signupBirthDateController.text}",
        name: "SIGNUP");
    final staffDao = database.staffDao;
    final Staff? staff =
        await staffDao.getStaffByNationalID(signupIDController.text);
    log("staff is found: ${staff != null}", name: "SIGNUP");
    if (staff == null) {
      final tempStaff = Staff(
          name: signupNameController.text,
          nationalId: signupIDController.text,
          password: signupPassController.text,
          role: int.parse(signupPhoneController.text),
          email: signupAddressController.text,
          salary: signupGenderController.text,
          startDate: signupBirthDateController.text);
      await staffDao.insertStaff(tempStaff);
      // final Staff? staff2 =
      //     await staffDao.getStaffByNationalID(signupIDController.text);
      log("staff is created", name: "SIGNUP");
      Navigator.pop(context);
      // if (staff2 != null) {
      //   Configs.staff = staff2;
      //
      //   // Navigator.pushAndRemoveUntil(
      //   //     context,
      //   //     MaterialPageRoute(
      //   //         builder: (context) => UserHomeScreen(database: database)),
      //   //     (route) => false);
      // }
    }
    if (staff != null) {
      log("Staff Already Exists", name: "SIGNUP");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // width: 400,
              height: 60,
              color: Colors.blueAccent,
              child: Center(
                child: Text(
                  "Add Staff",
                  style: MyStyles.normalText20,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
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
                        TextField(controller: signupIDController),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password",
                          style: MyStyles.normalText20,
                        ),
                        TextField(controller: signupPassController),
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
                        TextField(controller: signupNameController),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: MyStyles.normalText20,
                        ),
                        TextField(controller: signupAddressController),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start Date",
                          style: MyStyles.normalText20,
                        ),
                        TextField(controller: signupBirthDateController),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Salary",
                          style: MyStyles.normalText20,
                        ),
                        TextField(controller: signupGenderController),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Role",
                          style: MyStyles.normalText20,
                        ),
                        TextField(controller: signupPhoneController),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  if (signupNameController.text != "" &&
                      signupIDController.text != "" &&
                      signupPassController.text != "" &&
                      signupPhoneController.text != "") {
                    _signup(context);
                  } else {
                    log("pass or name or phone or id is empty", name: "SIGNUP");
                  }
                },
                child: Container(
                  height: 60,
                  width: 80,
                  decoration: MyStyles.roundedBox,
                  child: const Center(
                    child: Text("Add Staff"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  //
  // void _reserve(context, int roomid, Function callback) async {
  //   BookingStatus? bookingStatusWaiting =
  //       await database.bookingStatusDao.getBookingStatusByName("Waiting");
  //   log(
  //       "guest: ${Configs.guest!.id}, resDate: ${reserveDateController.text},"
  //       " bookstat: ${bookingStatusWaiting!.id}, checkin: "
  //       "${checkInDateController.text}, checkout: "
  //       "${checkOutDateController.text}, numNight: ${numOfNightsController.text}",
  //       name: "RESERVE");
  //
  //   Room? room = await database.roomDao.getRoomByID(roomid);
  //   RoomStatus? fullStatus =
  //       await database.roomStatusDao.getRoomStatusByName("Full");
  //   room!.status = fullStatus!.id!;
  //   await database.roomDao.updateRoom(room);
  //
  //   Reservation? res = await database.reservationDao.getReservationByDetails(
  //       Configs.guest!.id!,
  //       reserveDateController.text,
  //       checkInDateController.text,
  //       int.parse(numOfNightsController.text));
  //
  //   if (res == null) {
  //     log("creating reservation", name: "RESERVE");
  //     res = Reservation(
  //       guest: Configs.guest!.id!,
  //       reserveDate: reserveDateController.text,
  //       bookingStatus: bookingStatusWaiting.id!,
  //       checkInDate: checkInDateController.text,
  //       checkOutDate: checkOutDateController.text,
  //       noNights: int.parse(numOfNightsController.text),
  //     );
  //
  //     final int resID = await database.reservationDao.insertReservation(res);
  //
  //     ReservationDetails resD =
  //         ReservationDetails(room: roomid, reservation: resID);
  //
  //     await database.reservationDetailDao.insertReservationDetail(resD);
  //
  //     log("reserve successful", name: "RESERVE");
  //   } else {
  //     log("reservation found, adding to it", name: "RESERVE");
  //     ReservationDetails resD =
  //         ReservationDetails(room: roomid, reservation: res.id!);
  //
  //     await database.reservationDetailDao.insertReservationDetail(resD);
  //
  //     res.bookingStatus = bookingStatusWaiting.id!;
  //     database.reservationDao.updateReservation(res);
  //
  //     final Reservation? checkRes =
  //         await database.reservationDao.getReservationByID(res.id!);
  //
  //     log("reserve status: ${checkRes!.bookingStatus}", name: "RESERVE");
  //     log("reserve successful", name: "RESERVE");
  //   }
  //
  //   callback();
  //   Navigator.pop(context);
  // }
}
