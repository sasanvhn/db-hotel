import 'dart:developer';

import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/food/food_model.dart';
import 'package:db_hotel/db/food_order_relation/food_order_relation_model.dart';
import 'package:db_hotel/db/order/order_model.dart';
import 'package:db_hotel/db/reservation_details/reservation_details_model.dart';
import 'package:db_hotel/db/room/room_model.dart';
import 'package:db_hotel/db/staff/staff_model.dart';
import 'package:db_hotel/screens/request_cleaning_screen/request_cleaning_screen.dart';
import 'package:db_hotel/screens/restaurants_screen/user_restaurants_screen/user_restaurant_screen.dart';
import 'package:db_hotel/widgets/custom_appbar/custom_appbar.dart';
import 'package:db_hotel/widgets/home_floating_button/home_floating_button.dart';
import 'package:db_hotel/widgets/styles/my_styles.dart';
import 'package:flutter/material.dart';

class PreviousOrdersScreen extends StatefulWidget {
  const PreviousOrdersScreen(
      {Key? key,
      required this.database,
      required this.reservationID,
      required this.roomID})
      : super(key: key);

  final int reservationID;
  final int roomID;
  final AppDatabase database;

  @override
  _PreviousOrdersScreenState createState() => _PreviousOrdersScreenState();
}

class _PreviousOrdersScreenState extends State<PreviousOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titlee: "Previous Food Orders"),
      floatingActionButton:
          HomeFloatingButton(context: context, database: widget.database),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Row(
                  children: const [
                    Text("Orders: "),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Row(
                  children: const [
                    Text(" "),
                    SizedBox(
                      width: 10,
                    ),
                    // DropdownButton<String>(
                    //   value: dropDownVal,
                    //   items: <String>["All", "One Bed", "Two Bed", "Three Bed"]
                    //       .map((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    //   onChanged: (val) {
                    //     log("val is $val", name: "DROPDOWN");
                    //     setState(() {
                    //       val == null ? dropDownVal = "" : dropDownVal = val;
                    //     });
                    //   },
                    // )
                  ],
                ),
              ),
            ],
          ),
          FutureBuilder(
              future: _getOrders(),
              builder: (context, AsyncSnapshot<List<Order>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child:
                        //     ListView.builder(
                        //   shrinkWrap: true,
                        //   itemCount: snapshot.data!.length,
                        //   itemBuilder: (context, index) {
                        //     log(snapshot.data!.toString());
                        //     return Container();
                        //   },
                        // )
                        SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(snapshot.data!.length, (index) {
                          for (Order o in snapshot.data!) {
                            log("id : ${o.id}");
                          }
                          log("Order number #${snapshot.data![index].id} Ordered for ${snapshot.data![index].place == 0 ? 'Room' : 'Restaurant'}",
                              name: "ORDERS COLUMN");
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Order number #${snapshot.data![index].id} Ordered for ${snapshot.data![index].place == 0 ? 'Room' : 'Restaurant'}",
                                  style: MyStyles.bigText28),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 28, top: 18),
                                  child: FutureBuilder(
                                    future:
                                        _getFoods(snapshot.data![index].id!),
                                    builder: (context,
                                        AsyncSnapshot<Food> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Text(
                                            "${snapshot.data!.name}         ${snapshot.data!.price}\$        "
                                            "  ${snapshot.data!.type}");
                                      }
                                      return Container();
                                    },
                                  )),
                              const Divider()
                            ],
                          );
                        }),
                      ),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Container();
              })
        ],
      ),
    );
  }

  Future<List<Order>> _getOrders() async {
    log("in get orders with roomID ${widget.roomID} resID ${widget.reservationID}",
        name: "GET_ORDERS");
    ReservationDetails? rd = await widget.database.reservationDetailDao
        .getReservationDetailByResAndRoom(widget.reservationID, widget.roomID);
    log("rd id ${rd!.id}");
    final List<Order> orders =
        await widget.database.orderDao.getOrdersByRDID(rd.id!);

    log("this is orders: $orders", name: "GET_ORDERS");
    return orders;
  }

  Future<Food> _getFoods(int oid) async {
    log("in get foods for order $oid", name: "GET_FOODS");
    final List<FoodOrderRelation> f = await widget.database.foodOrderRelationDao
        .getFoodOrderRelationByOrderID(oid);
    log("this is f o r: $f", name: "GET_FOODS");
    final Food? ff = await widget.database.foodDao.getFoodByID(f.first.food);
    return ff!;
  }
}
