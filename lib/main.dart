import 'dart:developer';

import 'package:db_hotel/db/room_status/room_status_model.dart';
import 'package:db_hotel/db/room_type/room_type_model.dart';
import 'package:db_hotel/screens/first_screen/first_screen.dart';
import 'package:flutter/material.dart';

import 'db/database.dart';
import 'db/room/room_model.dart';

void main() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  deleteDB(database);
  dbUtil(database);
  runApp(MyApp(
    database: database,
  ));
}

void deleteDB(AppDatabase database) async {
  await database.generalDao.deleteSome();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.database}) : super(key: key);
  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstScreen(
        database: database,
      ),
    );
  }
}

void dbUtil(db) async {
  RoomType? a1 = await db.roomTypeDao.getRoomTypeByName("One Bed");
  if (a1 == null) {
    db.roomTypeDao.insertRoomType(
        RoomType(name: "One Bed", numberOfBeds: 1, image: "image"));
  }
  RoomType? a2 = await db.roomTypeDao.getRoomTypeByName("Two Bed");
  if (a2 == null) {
    db.roomTypeDao.insertRoomType(
        RoomType(name: "Two Bed", numberOfBeds: 2, image: "image"));
  }
  RoomType? a3 = await db.roomTypeDao.getRoomTypeByName("Three Bed");
  if (a3 == null) {
    db.roomTypeDao.insertRoomType(
        RoomType(name: "Three Bed", numberOfBeds: 3, image: "image"));
  }

  RoomStatus? b1 = await db.roomStatusDao.getRoomStatusByName("Available");
  if (b1 == null) {
    db.roomStatusDao.insertRoomStatus(RoomStatus(name: "Available"));
  }
  RoomStatus? b2 = await db.roomStatusDao.getRoomStatusByName("Full");
  if (b2 == null) {
    db.roomStatusDao.insertRoomStatus(RoomStatus(name: "Full"));
  }
  RoomStatus? b3 = await db.roomStatusDao.getRoomStatusByName("Out of Order");
  if (b3 == null) {
    db.roomStatusDao.insertRoomStatus(RoomStatus(name: "Out of Order"));
  }

  RoomType? roomTypeOneBed = await db.roomTypeDao.getRoomTypeByName("One Bed");
  RoomType? roomTypeTwoBed = await db.roomTypeDao.getRoomTypeByName("Two Bed");
  RoomType? roomTypeThreeBed =
      await db.roomTypeDao.getRoomTypeByName("Three Bed");

  RoomStatus? roomStatusAvailable =
      await db.roomStatusDao.getRoomStatusByName("Available");
  RoomStatus? roomStatusFull =
      await db.roomStatusDao.getRoomStatusByName("Full");
  RoomStatus? roomStatusOutOfOrder =
      await db.roomStatusDao.getRoomStatusByName("Out of Order");

  log("room type one bed: ${roomTypeOneBed!.name}", name: "DB UTIL");

  Room? r1 = await db.roomDao.getRoomByID(1);
  Room? r10 = await db.roomDao.getRoomByID(10);

  if (r1 == null && r10 == null) {
    db.roomDao.insertRoom(Room(
        number: 1,
        floor: 1,
        price: 50,
        type: roomTypeOneBed.id!,
        status: roomStatusAvailable!.id!));
    db.roomDao.insertRoom(Room(
        number: 2,
        floor: 1,
        price: 60,
        type: roomTypeTwoBed!.id!,
        status: roomStatusAvailable.id!));
    db.roomDao.insertRoom(Room(
        number: 3,
        floor: 1,
        price: 70,
        type: roomTypeThreeBed!.id!,
        status: roomStatusAvailable.id!));
    db.roomDao.insertRoom(Room(
        number: 4,
        floor: 2,
        price: 50,
        type: roomTypeOneBed.id!,
        status: roomStatusAvailable.id!));
    db.roomDao.insertRoom(Room(
        number: 5,
        floor: 2,
        price: 60,
        type: roomTypeTwoBed.id!,
        status: roomStatusAvailable.id!));
    db.roomDao.insertRoom(Room(
        number: 6,
        floor: 2,
        price: 70,
        type: roomTypeThreeBed.id!,
        status: roomStatusAvailable.id!));
    db.roomDao.insertRoom(Room(
        number: 7,
        floor: 3,
        price: 50,
        type: roomTypeOneBed.id!,
        status: roomStatusFull!.id!));
    db.roomDao.insertRoom(Room(
        number: 8,
        floor: 3,
        price: 60,
        type: roomTypeTwoBed.id!,
        status: roomStatusFull.id!));
    db.roomDao.insertRoom(Room(
        number: 9,
        floor: 3,
        price: 70,
        type: roomTypeThreeBed.id!,
        status: roomStatusFull.id!));
    db.roomDao.insertRoom(Room(
        number: 10,
        floor: 4,
        price: 50,
        type: roomTypeOneBed.id!,
        status: roomStatusOutOfOrder!.id!));
    db.roomDao.insertRoom(Room(
        number: 11,
        floor: 4,
        price: 60,
        type: roomTypeTwoBed.id!,
        status: roomStatusAvailable.id!));
  }
}
