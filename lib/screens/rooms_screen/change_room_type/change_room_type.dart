import 'dart:developer';
import 'package:db_hotel/db/database.dart';
import 'package:db_hotel/db/food/food_model.dart';
import 'package:db_hotel/db/room/room_model.dart';
import 'package:db_hotel/db/room_status/room_status_model.dart';
import 'package:db_hotel/db/room_type/room_type_model.dart';
import 'package:db_hotel/db/staff/staff_model.dart';
import 'package:db_hotel/widgets/styles/my_styles.dart';
import 'package:flutter/material.dart';

class ChangeType extends StatelessWidget {
  const ChangeType(
      {Key? key,
      required this.database,
      required this.callback,
      required this.roomId})
      : super(key: key);

  final AppDatabase database;
  final Function callback;
  final int roomId;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // width: 400,
              height: 60,
              color: Colors.blueAccent,
              child: Center(
                child: Text(
                  "Change Food Type",
                  style: MyStyles.normalText20,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {
                          _changeToOne(context);
                          log("changed");
                        },
                        child: const Text("Change To 1 Bed")),
                    TextButton(
                        onPressed: () {
                          _changeToTwo(context);
                          log("changed");
                        },
                        child: const Text("Change To 2 Bed")),
                    TextButton(
                        onPressed: () {
                          _changeToThree(context);
                          log("changed");
                        },
                        child: const Text("Change To 3 Bed")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changeToOne(context) async {
    final RoomType? rs =
        await database.roomTypeDao.getRoomTypeByName("One Bed");

    Room? r = await database.roomDao.getRoomByID(roomId);
    r!.type = rs!.id!;
    await database.roomDao.updateRoom(r);

    Navigator.pop(context);
    callback();
  }

  Future<void> _changeToTwo(context) async {
    final RoomType? rs =
        await database.roomTypeDao.getRoomTypeByName("Two Bed");

    Room? r = await database.roomDao.getRoomByID(roomId);
    r!.type = rs!.id!;
    await database.roomDao.updateRoom(r);

    Navigator.pop(context);
    callback();
  }

  Future<void> _changeToThree(context) async {
    final RoomType? rs =
        await database.roomTypeDao.getRoomTypeByName("Three Bed");

    Room? r = await database.roomDao.getRoomByID(roomId);
    r!.type = rs!.id!;
    await database.roomDao.updateRoom(r);

    Navigator.pop(context);
    callback();
  }
}
