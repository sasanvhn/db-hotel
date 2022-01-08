import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/screens/cleaning_requests_screen/cleaning_requests_screen.dart';
import 'package:db_hotel/screens/first_screen/first_screen.dart';
import 'package:db_hotel/screens/guests_screen/guests_screen.dart';
import 'package:db_hotel/screens/reservations_screen/all_reservations_screen/all_reservations_screen.dart';
import 'package:db_hotel/screens/reservations_screen/user_reservations_screen.dart';
import 'package:db_hotel/screens/reservations_screen/waiting_reservations_screen/waiting_reservations_screen.dart';
import 'package:db_hotel/screens/restaurants_screen/user_restaurants_screen/user_restaurant_screen.dart';
import 'package:db_hotel/screens/rich_customers_screen/rich_customers_screen.dart';
import 'package:db_hotel/screens/rooms_screen/all_rooms_screen/all_rooms_screen.dart';
import 'package:db_hotel/screens/rooms_screen/user_rooms_screen.dart';
import 'package:db_hotel/screens/staff_list_screen/staff_list_screen.dart';
import 'package:db_hotel/widgets/styles/my_styles.dart';
import 'package:flutter/material.dart';

import '../../../configs.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key, required this.database}) : super(key: key);

  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Home Screen"),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Text(
                Configs.staff!.name,
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
                  Configs.staff = null;
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
                            StaffListScreen(database: database))),
                child: Container(
                  width: 300,
                  height: 100,
                  decoration: MyStyles.roundedBox,
                  child: Center(
                    child: Text(
                      "Staff List",
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
              //               AllReservationsScreen(database: database))),
              //   child: Container(
              //     width: 300,
              //     height: 100,
              //     decoration: MyStyles.roundedBox,
              //     child: Center(
              //       child: Text(
              //         "All Reservations",
              //         style: MyStyles.normalText20,
              //       ),
              //     ),
              //   ),
              // ),
              // InkWell(
              //   onTap: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               AllRoomsScreen(database: database))),
              //   child: Container(
              //     width: 300,
              //     height: 100,
              //     decoration: MyStyles.roundedBox,
              //     child: Center(
              //       child: Text(
              //         "All Rooms",
              //         style: MyStyles.normalText20,
              //       ),
              //     ),
              //   ),
              // ),
              // InkWell(
              //   onTap: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               RichCustomersScreen(database: database))),
              //   child: Container(
              //     width: 300,
              //     height: 100,
              //     decoration: MyStyles.roundedBox,
              //     child: Center(
              //       child: Text(
              //         "Rich Guests",
              //         style: MyStyles.normalText20,
              //       ),
              //     ),
              //   ),
              // ),
              // InkWell(
              //   onTap: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               GuestsScreen(database: database))),
              //   child: Container(
              //     width: 300,
              //     height: 100,
              //     decoration: MyStyles.roundedBox,
              //     child: Center(
              //       child: Text(
              //         "Guests Rooms",
              //         style: MyStyles.normalText20,
              //       ),
              //     ),
              //   ),
              // ),
              // InkWell(
              //   onTap: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               CleaningRequestsScreen(database: database))),
              //   child: Container(
              //     width: 300,
              //     height: 100,
              //     decoration: MyStyles.roundedBox,
              //     child: Center(
              //       child: Text(
              //         "Cleaning Requests",
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
