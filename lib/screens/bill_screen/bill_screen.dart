import 'dart:developer';

import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/food/food_model.dart';
import 'package:db_hotel/db/food_order_relation/food_order_relation_model.dart';
import 'package:db_hotel/db/order/order_model.dart';
import 'package:db_hotel/db/reservation/reservation_model.dart';
import 'package:db_hotel/db/reservation_details/reservation_details_model.dart';
import 'package:db_hotel/db/room/room_model.dart';
import 'package:db_hotel/widgets/styles/my_styles.dart';
import 'package:flutter/material.dart';

class BillScreen extends StatelessWidget {
  const BillScreen(
      {Key? key, required this.database, required this.reservationID})
      : super(key: key);

  final AppDatabase database;
  final int reservationID;
  // int sum = 0;

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
              FutureBuilder(
                future: _getReservationDetails(),
                builder: (context,
                    AsyncSnapshot<List<ReservationDetails>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    log(snapshot.data!.length.toString());
                    int sum = 0;
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(snapshot.data!.length, (index) {
                          return FutureBuilder(
                            future: _getDetails(snapshot.data![index]),
                            builder: (context,
                                AsyncSnapshot<Map<String, int>> snapshot2) {
                              if (snapshot2.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              if (snapshot2.connectionState ==
                                  ConnectionState.done) {
                                sum = snapshot2.data!["room"]! + sum;
                                sum = snapshot2.data!["food"]! + sum;
                                return Column(
                                  children: [
                                    Text(
                                        "for room #${snapshot.data![index].room}:"),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 108.0),
                                      child: Text(
                                          "room: ${snapshot2.data!["room"]}, food: ${snapshot2.data!["food"]}"),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                );
                              }
                              return Container();
                            },
                          );
                        }));
                    // for (ReservationDetails rd in snapshot.data!) {
                    //   log(rd.toString());
                    //   return FutureBuilder(
                    //     future: _getDetails(rd),
                    //     builder: (context,
                    //         AsyncSnapshot<Map<String, int>> snapshot) {
                    //       if (snapshot.connectionState ==
                    //           ConnectionState.waiting) {
                    //         return const CircularProgressIndicator();
                    //       }
                    //       if (snapshot.connectionState ==
                    //           ConnectionState.done) {
                    //         // sum = sum +
                    //         //     int.parse(snapshot.data!["room"].toString());
                    //         // sum = sum +
                    //         //     int.parse(snapshot.data!["food"].toString());
                    //         return Column(
                    //           children: [
                    //             Text("for room #${rd.room}:"),
                    //             Padding(
                    //               padding: const EdgeInsets.only(left: 18.0),
                    //               child: Text(
                    //                   "room: ${snapshot.data!["room"]}, food: ${snapshot.data!["food"]}"),
                    //             )
                    //           ],
                    //         );
                    //       }
                    //       return Container();
                    //     },
                    //   );
                    // }
                  }
                  return Container();
                },
              ),
              // Text("sum: $sum"),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 60,
                    width: 80,
                    decoration: MyStyles.roundedBox,
                    child: const Center(
                      child: Text("OK"),
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

  Future<List<ReservationDetails>> _getReservationDetails() async {
    final List<ReservationDetails> rds =
        await database.reservationDetailDao.getRoomsIDsByResID(reservationID);
    log(rds.toString());
    return rds;
  }

  Future<Map<String, int>> _getDetails(ReservationDetails rd) async {
    Map<String, int> map = {"room": 0, "food": 0};
    final Room? room = await database.roomDao.getRoomByID(rd.room);
    final int roomPPN = room!.price;
    final Reservation? r =
        await database.reservationDao.getReservationByID(reservationID);
    final int? numOfNights = r!.noNights;
    map["room"] = roomPPN * numOfNights!;

    final List<Order> orders = await database.orderDao.getOrdersByRDID(rd.id!);
    int sumFoods = 0;
    for (Order o in orders) {
      final List<FoodOrderRelation> f = await database.foodOrderRelationDao
          .getFoodOrderRelationByOrderID(o.id!);
      // log("this is f o r: $f", name: "GET_FOODS");
      final Food? ff = await database.foodDao.getFoodByID(f.first.food);

      sumFoods += ff!.price;
    }

    map["food"] = sumFoods;

    return map;
  }
}
