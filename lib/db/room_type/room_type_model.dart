import 'package:floor/floor.dart';

const String desc = "this a base description for the room.";

@entity
class RoomType {
  RoomType(
      {this.id,
      required this.name,
      required this.numberOfBeds,
      required this.image,
      this.description = desc});

  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
  int numberOfBeds;
  String image;
  String description;
}

// 'CREATE TABLE IF NOT EXISTS `RoomType`
// (`id` INTEGER PRIMARY KEY AUTOINCREMENT,
// `name` TEXT NOT NULL,
// `numberOfBeds` INTEGER NOT NULL,
// `image` TEXT NOT NULL,
// `description` TEXT NOT NULL)'
