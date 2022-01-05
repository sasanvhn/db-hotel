import 'dart:developer';

import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/resturant_coffee_shop/resturant_coffeeshop_model.dart';
import 'package:db_hotel/screens/restaurant_menu_screen/restaurant_menu_screen.dart';

import 'package:db_hotel/widgets/custom_appbar/custom_appbar.dart';
import 'package:db_hotel/widgets/home_floating_button/home_floating_button.dart';
import 'package:flutter/material.dart';

class UserRestaurantsScreen extends StatefulWidget {
  const UserRestaurantsScreen({Key? key, required this.database})
      : super(key: key);

  final AppDatabase database;
  @override
  _UserRestaurantsScreenState createState() => _UserRestaurantsScreenState();
}

class _UserRestaurantsScreenState extends State<UserRestaurantsScreen> {
  String dropDownVal = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titlee: "Restaurants"),
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
                    Text("Restaurants:"),
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
              future: _getRestaurants(),
              builder: (context,
                  AsyncSnapshot<List<RestaurantCoffeeShop>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: DataTable(
                          columns: const [
                            DataColumn(label: Center(child: Text("Name"))),
                            DataColumn(label: Center(child: Text("Type"))),
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
                                      child: Text(
                                          snapshot.data![index].type == 0
                                              ? "Restaurant"
                                              : "CoffeeShop"),
                                    )),
                                    DataCell(Center(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RestaurantMenuScreen(
                                                        database:
                                                            widget.database,
                                                        restaurantName: snapshot
                                                            .data![index].name,
                                                        restaurantID: snapshot
                                                            .data![index].id!,
                                                      )));
                                        },
                                        child: const Text("Menu"),
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

  Future<List<RestaurantCoffeeShop>> _getRestaurants() async {
    if (dropDownVal == "All") {
      final List<RestaurantCoffeeShop> res =
          await widget.database.restaurantDao.getAll();

      return res;
    } else {
      final List<RestaurantCoffeeShop> res = await widget.database.restaurantDao
          .getRestaurantsByType(int.parse(dropDownVal));
      return res;
    }
  }
}
