import 'dart:developer';

import 'package:db_hotel/configs.dart';
import 'package:db_hotel/db/booking_status/booking_status_model.dart';
import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/guest/guest_model.dart';
import 'package:db_hotel/db/reservation/reservation_model.dart';
import 'package:db_hotel/screens/add_people_screen/add_people_screen.dart';
import 'package:db_hotel/screens/bill_screen/bill_screen.dart';
import 'package:db_hotel/widgets/custom_appbar/custom_appbar.dart';
import 'package:db_hotel/widgets/home_floating_button/home_floating_button.dart';
import 'package:flutter/material.dart';

class AllReservationsScreen extends StatefulWidget {
  const AllReservationsScreen({Key? key, required this.database})
      : super(key: key);

  final AppDatabase database;
  @override
  AllReservationsScreenState createState() => AllReservationsScreenState();
}

class AllReservationsScreenState extends State<AllReservationsScreen> {
  String dropDownVal = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titlee: "All Reservations"),
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
                    Text("All Reservations:"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Row(
                  children: [
                    const Text(" "),
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
                          dataRowHeight: 120,
                          columns: const [
                            DataColumn(label: Center(child: Text("Reserve"))),
                            DataColumn(label: Center(child: Text("Check In"))),
                            DataColumn(label: Center(child: Text("Check Out"))),
                            DataColumn(label: Center(child: Text("Nights"))),
                            DataColumn(label: Center(child: Text("Guest"))),
                            // DataColumn(label: Center(child: Text("Guest ID"))),
                            // DataColumn(label: Center(child: Text(" "))),
                            // DataColumn(label: Center(child: Text(" "))),
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
                                        future: _getGuest(
                                          snapshot.data![index].guest,
                                        ),
                                        builder: (context,
                                            AsyncSnapshot<Guest?> snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Text("Loading...");
                                          }
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "National ID: ${snapshot.data!.nationalId}"),
                                                Text(
                                                    "Name: ${snapshot.data!.name}"),
                                                Text(
                                                    "Gender: ${snapshot.data!.gender}"),
                                                Text(
                                                    "Phone: ${snapshot.data!.phoneNumber}"),
                                                Text(
                                                    "Address: ${snapshot.data!.address}"),
                                                Text(
                                                    "Birthdate: ${snapshot.data!.birthDate}"),
                                              ],
                                            );
                                          }
                                          return const Text("Loading...");
                                        },
                                      ),
                                    )),
                                    // DataCell(Center(
                                    //   child: TextButton(
                                    //     onPressed: () {
                                    //       setState(() {
                                    //         _decline(snapshot.data![index].id!);
                                    //         log("Reservation Declined",
                                    //             name: "DECLINE RES");
                                    //       });
                                    //     },
                                    //     child: const Text(
                                    //       "Decline",
                                    //       style: TextStyle(color: Colors.red),
                                    //     ),
                                    //   ),
                                    // )),
                                    // DataCell(Center(
                                    //   child: TextButton(
                                    //     onPressed: () {
                                    //       setState(() {
                                    //         _approve(snapshot.data![index].id!);
                                    //         log("Reservation Approved",
                                    //             name: "APPROVE RES");
                                    //       });
                                    //     },
                                    //     child: const Text("Approve",
                                    //         style:
                                    //             TextStyle(color: Colors.green)),
                                    //   ),
                                    // )),
                                    // DataCell(Center(
                                    //   child: TextButton(
                                    //     onPressed: () {
                                    //       showDialog(
                                    //           context: context,
                                    //           builder: (context) =>
                                    //               // Container());
                                    //               AlertDialog(
                                    //                 content: AddPeople(
                                    //                     database:
                                    //                         widget.database,
                                    //                     reservationID: snapshot
                                    //                         .data![index].id!),
                                    //                 contentPadding:
                                    //                     const EdgeInsets.all(0),
                                    //                 backgroundColor:
                                    //                     Colors.transparent,
                                    //               ));
                                    //     },
                                    //     child: const Text("Add Guest"),
                                    //   ),
                                    // )),
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

  Future<Guest?> _getGuest(int id) async {
    final Guest? bs = await widget.database.guestDao.getGuestByID(id);
    // log(message)
    if (bs != null) {
      return bs;
    }
    return null;
  }

  Future<List<Reservation>> _getReservations() async {
    if (dropDownVal == "All") {
      final BookingStatus? bs = await widget.database.bookingStatusDao
          .getBookingStatusByName("Approved");

      final List<Reservation> reservations =
          await widget.database.reservationDao.getAll();
      return reservations;
    } else {
      final BookingStatus? bs = await widget.database.bookingStatusDao
          .getBookingStatusByName(dropDownVal);

      final List<Reservation> reservations =
          await widget.database.reservationDao.getReservationByStatus(bs!.id!);
      return reservations;
    }
  }
}
