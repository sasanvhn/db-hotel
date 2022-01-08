import 'dart:developer';

import 'package:db_hotel/configs.dart';
import 'package:db_hotel/db/booking_status/booking_status_model.dart';
import 'package:db_hotel/db/cleaning_service/cleaning_service_model.dart';
import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/reservation/reservation_model.dart';
import 'package:db_hotel/db/reservation_details/reservation_details_model.dart';
import 'package:db_hotel/db/room/room_model.dart';
import 'package:db_hotel/db/staff/staff_model.dart';
import 'package:db_hotel/screens/add_people_screen/add_people_screen.dart';
import 'package:db_hotel/screens/assign_staff_to_cleaning_service/assign_staff_to_cleaning_service.dart';
import 'package:db_hotel/screens/bill_screen/bill_screen.dart';
import 'package:db_hotel/screens/reserved_room_screen/guest_reserved_rooms_screen/guest_reserved_rooms_screen.dart';
import 'package:db_hotel/widgets/custom_appbar/custom_appbar.dart';
import 'package:db_hotel/widgets/home_floating_button/home_floating_button.dart';
import 'package:flutter/material.dart';

class CleaningRequestsScreen extends StatefulWidget {
  const CleaningRequestsScreen({Key? key, required this.database})
      : super(key: key);

  final AppDatabase database;
  @override
  _CleaningRequestsScreenState createState() => _CleaningRequestsScreenState();
}

class _CleaningRequestsScreenState extends State<CleaningRequestsScreen> {
  String dropDownVal = "New";

  void callback() {
    setState(() {
      log("Screen Refreshed", name: "CLEANING_SERVICE_SCREEN");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titlee: "Cleaning Requests"),
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
                    Text("Cleaning Requests:"),
                  ],
                ),
              ),
              // TextButton(
              //     onPressed: () {
              //       setState(() {});
              //     },
              //     child: const Icon(Icons.refresh_sharp)),
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
                      items: <String>["New", "Old"].map((String value) {
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
              future: _getCleaningRequests(),
              builder: (context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: DataTable(
                          columns: const [
                            DataColumn(
                                label: Center(child: Text("Reservation"))),
                            DataColumn(
                                label: Center(child: Text("Room Number"))),
                            DataColumn(label: Center(child: Text("Date"))),
                            DataColumn(label: Center(child: Text("Time"))),
                            DataColumn(label: Center(child: Text("Staff"))),
                            DataColumn(label: Center(child: Text(" "))),
                            // DataColumn(label: Center(child: Text(" "))),
                            // DataColumn(label: Center(child: Text(" "))),
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
                                      child: Text(snapshot
                                          .data![index]["room"].id
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot
                                          .data![index]["cs"].date
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot
                                          .data![index]["cs"].time
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: FutureBuilder(
                                        future: _getStaff(
                                          snapshot.data![index]["cs"].staff,
                                        ),
                                        builder: (context,
                                            AsyncSnapshot<String> snapshot2) {
                                          if (snapshot2.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Text("Loading...");
                                          }
                                          if (snapshot2.connectionState ==
                                              ConnectionState.done) {
                                            return Text(
                                                "${snapshot.data![index]["cs"].staff ?? " "} - ${snapshot2.data!}");
                                          }
                                          return const Text("Loading...");
                                        },
                                      ),
                                    )),
                                    DataCell(Center(
                                      child: dropDownVal == "Old"
                                          ? const Text(" ")
                                          : TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          // Container());
                                                          AlertDialog(
                                                            content:
                                                                AssignStaffToCleaningService(
                                                              database: widget
                                                                  .database,
                                                              callback: callback,
                                                              cleaningServiceID:
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                          ["cs"]
                                                                      .id,
                                                            ),
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                          ));
                                                });
                                                setState(() {});
                                              },
                                              child: const Text("Assign Staff"),
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

  Future<String> _getStaff(int? id) async {
    if (id == null) return " ";
    final Staff? bs = await widget.database.staffDao.getStaffByID(id);

    if (bs != null) {
      return bs.name;
    }
    return "Loading...";
  }

  Future<List<Map>> _getCleaningRequests() async {
    List<Map> all = [];
    if (dropDownVal == "New") {
      final List<CleaningServiceModel> css =
          await widget.database.cleaningServiceDao.getNew();

      for (CleaningServiceModel cs in css) {
        final ReservationDetails? rd = await widget
            .database.reservationDetailDao
            .getRoomsIDByID(cs.reservationDetail);

        final Room? r = await widget.database.roomDao.getRoomByID(rd!.room);
        all.add({"cs": cs, "room": r, "res_id": rd.reservation});
      }

      return all;
    } else {
      final List<CleaningServiceModel> css =
          await widget.database.cleaningServiceDao.getAOld();

      for (CleaningServiceModel cs in css) {
        final ReservationDetails? rd = await widget
            .database.reservationDetailDao
            .getRoomsIDByID(cs.reservationDetail);

        final Room? r = await widget.database.roomDao.getRoomByID(rd!.room);
        all.add({"cs": cs, "room": r, "res_id": rd.reservation});
      }

      return all;
    }
  }
}
