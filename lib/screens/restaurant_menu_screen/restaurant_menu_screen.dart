import 'dart:developer';

import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/food/food_model.dart';
import 'package:db_hotel/db/resturant_coffee_shop/resturant_coffeeshop_model.dart';
import 'package:db_hotel/screens/food_order_screen/food_order_screen.dart';

import 'package:db_hotel/widgets/custom_appbar/custom_appbar.dart';
import 'package:db_hotel/widgets/home_floating_button/home_floating_button.dart';
import 'package:flutter/material.dart';

class RestaurantMenuScreen extends StatefulWidget {
  const RestaurantMenuScreen(
      {Key? key,
      required this.database,
      required this.restaurantID,
      required this.restaurantName,
      required this.roomID,
      required this.reservationID})
      : super(key: key);

  final AppDatabase database;
  final int restaurantID;
  final String restaurantName;
  final int reservationID;
  final int roomID;
  @override
  _RestaurantMenuScreenState createState() => _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {
  String dropDownVal = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titlee: "${widget.restaurantName} Menu"),
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
                    Text("Menu:"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Row(
                  children: [
                    const Text("Filter"),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButton<String>(
                      value: dropDownVal,
                      items: <String>["All", "0", "1"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (val) {
                        log("val is $val", name: "DROPDOWN");
                        setState(() {
                          val == null ? dropDownVal = "" : dropDownVal = val;
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
          FutureBuilder(
              future: _getFoods(),
              builder: (context, AsyncSnapshot<List<Food>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: DataTable(
                          columns: const [
                            DataColumn(label: Center(child: Text("Name"))),
                            DataColumn(label: Center(child: Text("Price"))),
                            DataColumn(label: Center(child: Text("Type"))),
                            DataColumn(
                                label: Center(child: Text("Ingredients"))),
                            DataColumn(label: Center(child: Text(" "))),
                          ],
                          rows: List.generate(
                              snapshot.data!.length,
                              (index) => DataRow(cells: [
                                    DataCell(Center(
                                      child: Text(snapshot.data![index].name
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot.data![index].price
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(
                                          snapshot.data![index].type == 0
                                              ? "Food"
                                              : "Drink"),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot
                                          .data![index].ingredients
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: TextButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  // Container());
                                                  AlertDialog(
                                                    content: FoodOrder(
                                                      reservationID:
                                                          widget.reservationID,
                                                      roomID: widget.roomID,
                                                      database: widget.database,
                                                      foodID: snapshot
                                                          .data![index].id!,
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  ));
                                        },
                                        child: const Text("Order"),
                                      ),
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

  Future<List<Food>> _getFoods() async {
    if (dropDownVal == "All") {
      log("getting foods", name: "FOOD MENU");
      final List<Food> res =
          await widget.database.foodDao.getFoodByShopID(widget.restaurantID);
      log("got foods $res", name: "FOOD MENU");

      return res;
    } else {
      final List<Food> res = await widget.database.foodDao
          .getFoodByShopIDAndType(widget.restaurantID, int.parse(dropDownVal));
      return res;
    }
  }
}
