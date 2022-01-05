import 'dart:developer';

import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/room/room_model.dart';
import 'package:db_hotel/screens/request_cleaning_screen/request_cleaning_screen.dart';
import 'package:db_hotel/widgets/custom_appbar/custom_appbar.dart';
import 'package:db_hotel/widgets/home_floating_button/home_floating_button.dart';
import 'package:flutter/material.dart';

class UserReservedRoomsScreen extends StatefulWidget {
  const UserReservedRoomsScreen(
      {Key? key, required this.database, required this.reservationID})
      : super(key: key);

  final int reservationID;
  final AppDatabase database;

  @override
  _UserReservedRoomsScreenState createState() =>
      _UserReservedRoomsScreenState();
}

class _UserReservedRoomsScreenState extends State<UserReservedRoomsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titlee: "Rooms for this reservation"),
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
                    Text("Rooms: "),
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
                    //   items: <String>["All", "One Bed", "Two Bed", "Three Bed"]
                    //       .map((String value) {
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
              future: _getRooms(),
              builder: (context, AsyncSnapshot<List<Room>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: DataTable(
                          columns: const [
                            DataColumn(label: Center(child: Text("Number"))),
                            DataColumn(label: Center(child: Text("Floor"))),
                            DataColumn(label: Center(child: Text("Price"))),
                            DataColumn(
                                label: Center(child: Text("Max Capacity"))),
                            DataColumn(label: Center(child: Text("Type"))),
                            DataColumn(label: Center(child: Text(" "))),
                            DataColumn(label: Center(child: Text(" "))),
                          ],
                          rows: List.generate(
                              snapshot.data!.length,
                              (index) => DataRow(cells: [
                                    DataCell(Center(
                                      child: Text(snapshot.data![index].number
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot.data![index].floor
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot.data![index].price
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot.data![index].capacity
                                          .toString()),
                                    )),
                                    DataCell(Center(
                                      child: Text(snapshot.data![index].type
                                              .toString() +
                                          " Beds"),
                                    )),
                                    DataCell(Center(
                                      child: TextButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  // Container());
                                                  AlertDialog(
                                                    content: RequestCleaning(
                                                      database: widget.database,
                                                      roomID: snapshot
                                                          .data![index].id!,
                                                      reservationID:
                                                          widget.reservationID,
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  ));
                                        },
                                        child: const Text("Request Cleaning"),
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
                                        child: const Text("Add Guest"),
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

  Future<List<Room>> _getRooms() async {
    log("in get rooms with rid ${widget.reservationID}", name: "GET_ROOMS");
    final List<Room> rooms = await widget.database.roomDao
        .getRoomsByReservationID(widget.reservationID);
    log("this is rooms: $rooms", name: "GET_ROOMS");
    return rooms;
  }
}
