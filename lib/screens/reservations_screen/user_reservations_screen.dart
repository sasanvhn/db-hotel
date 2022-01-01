import 'dart:developer';

import 'package:db_hotel/configs.dart';
import 'package:db_hotel/db/booking_status/booking_status_model.dart';
import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/reservation/reservation_model.dart';
import 'package:db_hotel/screens/user_reserved_room_screen/user_reserved_rooms_screen.dart';
import 'package:db_hotel/widgets/custom_appbar/custom_appbar.dart';
import 'package:db_hotel/widgets/home_floating_button/home_floating_button.dart';
import 'package:flutter/material.dart';

class UserReservationsScreen extends StatefulWidget {
  const UserReservationsScreen({Key? key, required this.database})
      : super(key: key);

  final AppDatabase database;
  @override
  _UserReservationsScreenState createState() => _UserReservationsScreenState();
}

class _UserReservationsScreenState extends State<UserReservationsScreen> {
  String dropDownVal = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titlee: "Reservations"),
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
                    Text("Reservations:"),
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
                      items: <String>["All", "Approved", "Declined", "Waiting"]
                          .map((String value) {
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
              future: _getReservations(),
              builder: (context, AsyncSnapshot<List<Reservation>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: DataTable(
                          columns: const [
                            DataColumn(label: Center(child: Text("Reserve"))),
                            DataColumn(label: Center(child: Text("Check In"))),
                            DataColumn(label: Center(child: Text("Check Out"))),
                            DataColumn(label: Center(child: Text("Nights"))),
                            DataColumn(label: Center(child: Text("Status"))),
                            DataColumn(label: Center(child: Text(" "))),
                            DataColumn(label: Center(child: Text(" "))),
                          ],
                          rows: List.generate(
                              snapshot.data!.length,
                              (index) => DataRow(cells: [
                                    DataCell(Center(
                                      child: Text(snapshot
                                          .data![index].reserveDate
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot
                                          .data![index].checkInDate
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot
                                          .data![index].checkOutDate
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot.data![index].noNights
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: FutureBuilder(
                                        future: _getStatusName(
                                          snapshot.data![index].bookingStatus,
                                        ),
                                        builder: (context,
                                            AsyncSnapshot<String> snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Text("Loading...");
                                          }
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return Text(snapshot.data!);
                                          }
                                          return const Text("Loading...");
                                        },
                                      ),
                                    )),
                                    DataCell(Center(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserReservedRoomsScreen(
                                                        database:
                                                            widget.database,
                                                        reservationID: snapshot
                                                            .data![index].id!,
                                                      )));
                                        },
                                        child: const Text("Rooms"),
                                      ),
                                    )),
                                    DataCell(Center(
                                      child: TextButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  Container());
                                          // AlertDialog(
                                          //   content: Reserve(
                                          //       database:
                                          //           widget.database,
                                          //       roomID: snapshot
                                          //           .data![index]!.id!,
                                          //       callback: callback),
                                          //   contentPadding:
                                          //       const EdgeInsets.all(0),
                                          //   backgroundColor:
                                          //       Colors.transparent,
                                          // ));
                                        },
                                        child: const Text("Bill"),
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

  Future<String> _getStatusName(int id) async {
    final BookingStatus? bs =
        await widget.database.bookingStatusDao.getBookingStatusByID(id);

    if (bs != null) {
      return bs.name;
    }
    return "Loading...";
  }

  Future<List<Reservation>> _getReservations() async {
    if (dropDownVal == "All") {
      final List<Reservation> reservations = await widget
          .database.reservationDao
          .getReservationByGuestID(Configs.guest!.id!);

      return reservations;
    } else {
      final BookingStatus? bs = await widget.database.bookingStatusDao
          .getBookingStatusByName(dropDownVal);

      final List<Reservation> reservations = await widget
          .database.reservationDao
          .getReservationByGuestIDAndStatus(Configs.guest!.id!, bs!.id!);
      return reservations;
    }
  }
}
