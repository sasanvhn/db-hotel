import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/screens/first_screen/first_screen.dart';
import 'package:db_hotel/screens/reservations_screen/user_reservations_screen.dart';
import 'package:db_hotel/screens/restaurants_screen/user_restaurants_screen/user_restaurant_screen.dart';
import 'package:db_hotel/screens/rooms_screen/user_rooms_screen.dart';
import 'package:db_hotel/widgets/styles/my_styles.dart';
import 'package:flutter/material.dart';

import '../../../configs.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key, required this.database}) : super(key: key);

  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guest Home Screen"),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Text(
                Configs.guest!.name,
                style: MyStyles.normalText20,
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.account_circle,
                size: 40,
              ),
              const SizedBox(
                width: 40,
              ),
              InkWell(
                child: Text(
                  "Log Out",
                  style: MyStyles.normalText20,
                ),
                onTap: () {
                  Configs.guest = null;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FirstScreen(database: database)),
                      (route) => false);
                },
              )
            ],
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Center(
          child: Wrap(
            spacing: 30,
            runSpacing: 30,
            children: [
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UserRoomsScreen(database: database))),
                child: Container(
                  width: 300,
                  height: 100,
                  decoration: MyStyles.roundedBox,
                  child: Center(
                    child: Text(
                      "Available Rooms",
                      style: MyStyles.normalText20,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UserReservationsScreen(database: database))),
                child: Container(
                  width: 300,
                  height: 100,
                  decoration: MyStyles.roundedBox,
                  child: Center(
                    child: Text(
                      "Reservations",
                      style: MyStyles.normalText20,
                    ),
                  ),
                ),
              ),
              // InkWell(
              //   onTap: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               UserRestaurantsScreen(database: database))),
              //   child: Container(
              //     width: 300,
              //     height: 100,
              //     decoration: MyStyles.roundedBox,
              //     child: Center(
              //       child: Text(
              //         "Restaurants | CoffeeShops",
              //         style: MyStyles.normalText20,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
