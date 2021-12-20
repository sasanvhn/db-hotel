import 'package:floor/floor.dart';

@entity
class Staff {
  Staff(
      {this.startDate = "today",
      this.salary = "base salary",
      required this.password,
      required this.name,
      required this.nationalId,
      required this.email,
      this.role = 0});

  @PrimaryKey(autoGenerate: true)
  int? id;
  String startDate;
  String salary;
  String password;
  String nationalId;
  String name;

  String email;
  int role; //0: receptionist - 1: cleaning staff
}

// 'CREATE TABLE IF NOT EXISTS `Staff`
// (`id` INTEGER PRIMARY KEY AUTOINCREMENT,
// `startDate` TEXT NOT NULL,
// `salary` TEXT NOT NULL,
// `password` TEXT NOT NULL,
// `nationalId` TEXT NOT NULL,
// `name` TEXT NOT NULL,
// `email` TEXT NOT NULL,
// `role` INTEGER NOT NULL)'
