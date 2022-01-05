import 'package:db_hotel/db/people/people_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class PeopleDao {
  @insert
  Future<void> insertGuest(People p);
}
