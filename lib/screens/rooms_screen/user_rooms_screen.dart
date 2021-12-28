import 'dart:developer';

import 'package:db_hotel/configs.dart';
import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/room/room_model.dart';
import 'package:db_hotel/db/room_status/room_status_model.dart';
import 'package:db_hotel/db/room_type/room_type_model.dart';
import 'package:db_hotel/widgets/custom_appbar/custom_appbar.dart';
import 'package:db_hotel/widgets/home_floating_button/home_floating_button.dart';
import 'package:flutter/material.dart';

class UserRoomsScreen extends StatefulWidget {
  const UserRoomsScreen({Key? key, required this.database}) : super(key: key);

  final AppDatabase database;

  @override
  _UserRoomsScreenState createState() => _UserRoomsScreenState();
}

class _UserRoomsScreenState extends State<UserRoomsScreen> {
  String dropDownVal = "All";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titlee: 'Rooms Screen',
      ),
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
                    Text("From"),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 30,
                      child: TextField(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("To"),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 30,
                      child: TextField(),
                    ),
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
                      items: <String>["All", "One Bed", "Two Bed", "Three Bed"]
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
              future: _getRooms(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return DataTable(columns: const [
                    DataColumn(label: Text("Number")),
                    DataColumn(label: Text("Floor")),
                    DataColumn(label: Text("Price")),
                    DataColumn(label: Text("Max Capacity")),
                    DataColumn(label: Text("Type")),
                  ], rows: []);
                }
                return Container();
              })
        ],
      ),
      floatingActionButton:
          HomeFloatingButton(context: context, database: widget.database),
    );
  }

  Future<Room?> _getRooms() async {
    RoomStatus? availableRoomStatus =
        await widget.database.roomStatusDao.getRoomStatusByName("Available");
    if (availableRoomStatus == null) {
      log("status not found", name: "GET ROOMS");
    } else {
      if (dropDownVal == "All") {
        return await widget.database.roomDao
            .getRoomsByStatusID(availableRoomStatus.id!);
      } else {
        RoomType? selectedRoomType =
            await widget.database.roomTypeDao.getRoomTypeByName(dropDownVal);
        if (selectedRoomType == null) {
          log("type not found", name: "GET ROOMS");
        } else {
          final rooms = await widget.database.roomDao
              .getRoomsByTypeIDAndStatusID(
                  selectedRoomType.id!, availableRoomStatus.id!);
          log("rooms: $rooms", name: "GET ROOMS");
          return rooms;
        }
      }
    }
  }
}
