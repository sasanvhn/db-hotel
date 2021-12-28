import 'package:floor/floor.dart';

@entity
class Guest {
  Guest(
      {this.id,
      required this.name,
      required this.nationalId,
      this.gender,
      this.address,
      this.birthDate,
      required this.password,
      required this.phoneNumber});

  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
  String nationalId;
  String? gender;
  String? address;
  String? birthDate;
  String password;
  String phoneNumber;
}

// 'CREATE TABLE IF NOT EXISTS `Guest`
// (`id` INTEGER PRIMARY KEY AUTOINCREMENT,
// `name` TEXT NOT NULL,
// `nationalId` TEXT NOT NULL,
// `gender` TEXT,
// `address` TEXT,
// `birthDate` TEXT,
// `password` TEXT NOT NULL,
// `phoneNumber` TEXT NOT NULL)'
