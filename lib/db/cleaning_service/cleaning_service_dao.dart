import 'cleaning_service_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class CleaningServiceDao {
  @insert
  Future<void> insertCleaningService(CleaningServiceModel cleaningService);

  // @Query('SELECT * FROM CleaningServiceModel')
  // Future<List<CleaningServiceModel>?> getAll();

  // @delete
  // Future<void> deleteCleaningServiceModel(
  //     CleaningServiceModel cleaningServiceModel);
}
