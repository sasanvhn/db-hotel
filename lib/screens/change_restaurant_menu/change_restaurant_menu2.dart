import 'dart:developer';

import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/food/food_model.dart';
import 'package:db_hotel/screens/add_food_screen/add_food_screen.dart';
import 'package:db_hotel/widgets/custom_appbar/custom_appbar.dart';
import 'package:db_hotel/widgets/home_floating_button/home_floating_button.dart';
import 'package:flutter/material.dart';

class RestaurantChangeMenuScreen extends StatefulWidget {
  const RestaurantChangeMenuScreen({
    Key? key,
    required this.database,
    required this.restaurantID,
    required this.restaurantName,
  }) : super(key: key);

  final AppDatabase database;
  final int restaurantID;
  final String restaurantName;

  @override
  _RestaurantChangeMenuScreenState createState() =>
      _RestaurantChangeMenuScreenState();
}

class _RestaurantChangeMenuScreenState
    extends State<RestaurantChangeMenuScreen> {
  String dropDownVal = "All";

  void callback() {
    setState(() {});
  }

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
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: AddFoodScreen(
                                  database: widget.database,
                                  restaurantId: widget.restaurantID,
                                  callback: callback),
                              backgroundColor: Colors.transparent,
                              contentPadding: const EdgeInsets.all(0),
                            ));
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.green,
                  )),
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
                                          _deleteFood(
                                              snapshot.data![index].id!);
                                          log("Deleted");
                                        },
                                        child: const Icon(
                                          Icons.delete_forever,
                                          color: Colors.red,
                                        ),
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

  void _deleteFood(int food) async {
    final Food? f = await widget.database.foodDao.getFoodByID(food);
    final int a = await widget.database.foodDao.deleteFoods([f!]);

    setState(() {
      log(a.toString());
    });
  }
}
