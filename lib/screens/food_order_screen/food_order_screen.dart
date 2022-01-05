import 'dart:developer';

import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/food_order_relation/food_order_relation_model.dart';
import 'package:db_hotel/db/order/order_model.dart';
import 'package:db_hotel/db/reservation_details/reservation_details_model.dart';
import 'package:db_hotel/widgets/styles/my_styles.dart';
import 'package:flutter/material.dart';

class FoodOrder extends StatelessWidget {
  FoodOrder(
      {Key? key,
      required this.database,
      required this.foodID,
      required this.reservationID,
      required this.roomID})
      : super(key: key);

  final AppDatabase database;
  final int foodID;
  final int reservationID;
  final int roomID;

  final TextEditingController placeController = TextEditingController();

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
              Text("your room ID is $roomID"),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "room(0) or shop(1)?",
                    style: MyStyles.normalText20,
                  ),
                  TextField(controller: placeController),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    if (placeController.text != "") {
                      _order(context);
                    } else {
                      log("roomID or place is empty", name: "ORDER");
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 80,
                    decoration: MyStyles.roundedBox,
                    child: const Center(
                      child: Text("Order"),
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

  void _order(context) async {
    ReservationDetails? rd = await database.reservationDetailDao
        .getReservationDetailByResAndRoom(reservationID, roomID);

    Order o = Order(
        place: int.parse(placeController.text), reservationDetail: rd!.id!);

    int o12 = await database.orderDao.insertOrder(o);

    // List<Order> os = await database.orderDao.getOrdersByReservationDetailID();

    // Order o1 = os.last;

    log("Added order $o12", name: "ADD ORDER");

    FoodOrderRelation fr = FoodOrderRelation(food: foodID, order: o12);

    await database.foodOrderRelationDao.insertFoodOrderRelation(fr);

    log("Added Order", name: "ADD ORDER");

    Navigator.pop(context);
  }
}
