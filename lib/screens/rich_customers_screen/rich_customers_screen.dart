import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/food/food_model.dart';
import 'package:db_hotel/db/food_order_relation/food_order_relation_model.dart';
import 'package:db_hotel/db/guest/guest_model.dart';
import 'package:db_hotel/db/order/order_model.dart';
import 'package:db_hotel/db/reservation/reservation_model.dart';
import 'package:db_hotel/db/reservation_details/reservation_details_model.dart';
import 'package:db_hotel/db/room/room_model.dart';

import 'package:db_hotel/widgets/custom_appbar/custom_appbar.dart';
import 'package:db_hotel/widgets/home_floating_button/home_floating_button.dart';
import 'package:flutter/material.dart';

class RichCustomersScreen extends StatefulWidget {
  const RichCustomersScreen({Key? key, required this.database})
      : super(key: key);

  final AppDatabase database;
  @override
  RichCustomersScreenState createState() => RichCustomersScreenState();
}

class RichCustomersScreenState extends State<RichCustomersScreen> {
  late Future<List<Map<dynamic, dynamic>>> allThings;

  @override
  initState() {
    allThings = _getAll();
    super.initState();
  }

  // int dropDownVal = 300;
  TextEditingController lowerLimitController =
      TextEditingController(text: "300");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titlee: "Rich Customers"),
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
                    Text("Rich Customers:"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Row(
                  children: [
                    const Text("Lower Limit: "),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        controller: lowerLimitController,
                        onChanged: (String a) {
                          setState(() {});
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          FutureBuilder(
              future: _getRiches(),
              builder: (context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: DataTable(
                          // dataRowHeight: 120,
                          columns: const [
                            DataColumn(
                                label: Center(child: Text("Reservation ID"))),
                            DataColumn(label: Center(child: Text("Guest ID"))),
                            DataColumn(
                                label: Center(child: Text("Guest Name"))),
                            DataColumn(
                                label: Center(child: Text("Sum of Expenses"))),
                          ],
                          rows: List.generate(
                              snapshot.data!.length,
                              (index) => DataRow(cells: [
                                    DataCell(Center(
                                      child: Text(snapshot.data![index]
                                              ["res_id"]
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot.data![index]
                                              ["guest_id"]
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot.data![index]
                                              ["guest_name"]
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot.data![index]["sum"]
                                          .toString()),
                                    )),
                                  ]))),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return const Text("error");
                }
                return Container();
              })
        ],
      ),
    );
  }

  Future<List<Map>> _getRiches() async {
    List<Map> riches = [];
    int limit = lowerLimitController.text == ""
        ? 0
        : int.parse(lowerLimitController.text);
    allThings.then((value) {
      for (Map m in value) {
        if (m["sum"] > limit) {
          riches.add(m);
        }
      }
    });

    return riches;
  }

  Future<List<Map>> _getAll() async {
    List<Map> allThings = [];
    final List<Reservation> rs = await widget.database.reservationDao.getAll();

    for (Reservation res in rs) {
      int sum = 0;
      final List<ReservationDetails> rds = await widget
          .database.reservationDetailDao
          .getRoomsIDsByResID(res.id!);

      for (ReservationDetails rd in rds) {
        sum = 0;
        final Room? room = await widget.database.roomDao.getRoomByID(rd.room);
        final int roomPPN = room!.price;
        final Reservation? r =
            await widget.database.reservationDao.getReservationByID(res.id!);
        final int? numOfNights = r!.noNights;
        sum += roomPPN * numOfNights!;

        final List<Order> orders =
            await widget.database.orderDao.getOrdersByRDID(rd.id!);
        // int sumFoods = 0;
        for (Order o in orders) {
          final List<FoodOrderRelation> f = await widget
              .database.foodOrderRelationDao
              .getFoodOrderRelationByOrderID(o.id!);
          // log("this is f o r: $f", name: "GET_FOODS");
          final Food? ff =
              await widget.database.foodDao.getFoodByID(f.first.food);

          sum += ff!.price;
        }
      }
      final Guest? g = await widget.database.guestDao.getGuestByID(res.guest);
      allThings.add({
        "guest_id": g!.nationalId,
        "guest_name": g.name,
        "res_id": res.id,
        "sum": sum
      });
    }

    return allThings;
  }
}
