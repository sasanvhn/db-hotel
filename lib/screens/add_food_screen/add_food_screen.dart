import 'dart:developer';
import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/food/food_model.dart';
import 'package:db_hotel/db/staff/staff_model.dart';
import 'package:db_hotel/widgets/styles/my_styles.dart';
import 'package:flutter/material.dart';

class AddFoodScreen extends StatelessWidget {
  AddFoodScreen(
      {Key? key,
      required this.database,
      required this.callback,
      required this.restaurantId})
      : super(key: key);

  final AppDatabase database;
  final Function callback;
  final int restaurantId;

  final TextEditingController signupNameController = TextEditingController();
  final TextEditingController signupPassController = TextEditingController();
  final TextEditingController signupIDController = TextEditingController();
  final TextEditingController signupGenderController = TextEditingController();
  final TextEditingController signupAddressController = TextEditingController();
  final TextEditingController signupBirthDateController =
      TextEditingController();
  final TextEditingController signupPhoneController = TextEditingController();

  void _signup(context) async {
    final foodDao = database.foodDao;

    final tempFood = Food(
        name: signupNameController.text,
        price: int.parse(signupPassController.text),
        type: int.parse(signupIDController.text),
        ingredients: signupAddressController.text,
        shopId: restaurantId);
    await foodDao.insertFood(tempFood);

    log("staff is created", name: "SIGNUP");
    Navigator.pop(context);
    callback();
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
                  "Add Food",
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
                          "Price",
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
                          "Type (0:food, 1:drink)",
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
                          "Ingredients",
                          style: MyStyles.normalText20,
                        ),
                        TextField(controller: signupAddressController),
                      ],
                    ),
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
                      signupAddressController.text != "") {
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
                    child: Text("Add Food"),
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
