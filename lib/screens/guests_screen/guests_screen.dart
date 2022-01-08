import 'dart:developer';

import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/guest/guest_model.dart';
import 'package:db_hotel/db/room/room_model.dart';
import 'package:db_hotel/db/room_status/room_status_model.dart';
import 'package:db_hotel/db/room_type/room_type_model.dart';
import 'package:db_hotel/screens/reservations_screen/guest_reservation_screen/guest_reservations_screen.dart';
import 'package:db_hotel/widgets/custom_appbar/custom_appbar.dart';
import 'package:db_hotel/widgets/home_floating_button/home_floating_button.dart';
import 'package:flutter/material.dart';

class GuestsScreen extends StatefulWidget {
  const GuestsScreen({Key? key, required this.database}) : super(key: key);

  final AppDatabase database;
  @override
  GuestsScreenState createState() => GuestsScreenState();
}

class GuestsScreenState extends State<GuestsScreen> {
  // String dropDownVal = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titlee: "All Guests"),
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
                    Text("All Guests:"),
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
                    //   items: <String>[
                    //     "All",
                    //     "Available",
                    //     "Full",
                    //     "Out of Order"
                    //   ].map((String value) {
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
              future: _getGuests(),
              builder: (context, AsyncSnapshot<List<Guest>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: DataTable(
                          // dataRowHeight: 120,
                          columns: const [
                            DataColumn(label: Center(child: Text("Guest ID"))),
                            DataColumn(label: Center(child: Text("Name"))),
                            DataColumn(label: Center(child: Text("Phone"))),
                            DataColumn(label: Center(child: Text(" "))),
                          ],
                          rows: List.generate(
                              snapshot.data!.length,
                              (index) => DataRow(cells: [
                                    DataCell(Center(
                                      child: Text(snapshot
                                          .data![index].nationalId
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot.data![index].name
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot
                                          .data![index].phoneNumber
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      GuestReservationsScreen(
                                                          database:
                                                              widget.database,
                                                          guest: snapshot
                                                              .data![index]
                                                              .id!)));
                                        },
                                        child: const Text("Reservations"),
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

  Future<List<Guest>> _getGuests() async {
    return await widget.database.guestDao.getAll();
  }
}
