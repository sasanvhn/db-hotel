import 'dart:developer';

import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/room/room_model.dart';
import 'package:db_hotel/db/room_status/room_status_model.dart';
import 'package:db_hotel/db/room_type/room_type_model.dart';
import 'package:db_hotel/screens/rooms_screen/change_room_type/change_room_type.dart';
import 'package:db_hotel/widgets/custom_appbar/custom_appbar.dart';
import 'package:db_hotel/widgets/home_floating_button/home_floating_button.dart';
import 'package:flutter/material.dart';

class AdminAllRoomsScreen extends StatefulWidget {
  const AdminAllRoomsScreen({Key? key, required this.database})
      : super(key: key);

  final AppDatabase database;
  @override
  AdminAllRoomsScreenState createState() => AdminAllRoomsScreenState();
}

class AdminAllRoomsScreenState extends State<AdminAllRoomsScreen> {
  String dropDownVal = "All";

  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titlee: "All Rooms"),
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
                    Text("All Rooms:"),
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
                      items: <String>[
                        "All",
                        "Available",
                        "Full",
                        "Out of Order"
                      ].map((String value) {
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
              future: _getRooms(),
              builder: (context, AsyncSnapshot<List<Room>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: DataTable(
                          // dataRowHeight: 120,
                          columns: const [
                            DataColumn(label: Center(child: Text("Number"))),
                            DataColumn(label: Center(child: Text("Floor"))),
                            DataColumn(label: Center(child: Text("Price"))),
                            DataColumn(label: Center(child: Text("Capacity"))),
                            DataColumn(label: Center(child: Text("Type"))),
                            DataColumn(label: Center(child: Text("Status"))),
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
                                        child: FutureBuilder(
                                      future: _getType(
                                        snapshot.data![index].type,
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
                                    ))),
                                    DataCell(Center(
                                      child: FutureBuilder(
                                        future: _getStatus(
                                          snapshot.data![index].status,
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
                                          setState(() {
                                            _toggle(snapshot.data![index]);
                                            log("toggle status",
                                                name: "TOGGLE_STATUS");
                                          });
                                        },
                                        child: const Text("Toggle Status",
                                            style:
                                                TextStyle(color: Colors.green)),
                                      ),
                                    )),
                                    DataCell(Center(
                                      child: TextButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  // Container());
                                                  AlertDialog(
                                                    content: ChangeType(
                                                      database: widget.database,
                                                      roomId: snapshot
                                                          .data![index].id!,
                                                      callback: callback,
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  ));
                                        },
                                        child: const Text("Change Type"),
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

  Future<String> _getType(int id) async {
    final RoomType? bs = await widget.database.roomTypeDao.getRoomTypeByID(id);
    // log(message)
    if (bs != null) {
      return bs.name;
    }
    return "Loading...";
  }

  void _toggle(Room room) async {
    final RoomStatus? av =
        await widget.database.roomStatusDao.getRoomStatusByName("Available");

    final RoomStatus? out =
        await widget.database.roomStatusDao.getRoomStatusByName("Out of Order");

    if (room.status == av!.id) {
      room.status = out!.id!;
      await widget.database.roomDao.updateRoom(room);
    } else if (room.status == out!.id) {
      room.status = av.id!;
      await widget.database.roomDao.updateRoom(room);
    }
    setState(() {});
  }

  Future<String> _getStatus(int id) async {
    final RoomStatus? bs =
        await widget.database.roomStatusDao.getRoomStatusByID(id);
    // log(message)
    if (bs != null) {
      return bs.name;
    }
    return "Loading...";
  }

  Future<List<Room>> _getRooms() async {
    if (dropDownVal == "All") {
      final List<Room> rooms = await widget.database.roomDao.getAll();
      return rooms;
    } else {
      final RoomStatus? bs =
          await widget.database.roomStatusDao.getRoomStatusByName(dropDownVal);

      final List<Room> rooms =
          await widget.database.roomDao.getRoomsByStatusID(bs!.id!);
      return rooms;
    }
  }
}
