import 'cleaning_service_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class CleaningServiceDao {
  @insert
  Future<void> insertCleaningService(CleaningServiceModel cleaningService);

  @Query('SELECT * FROM CleaningServiceModel')
  Future<List<CleaningServiceModel>> getAll();

  @Query('SELECT * FROM CleaningServiceModel where staff is null')
  Future<List<CleaningServiceModel>> getNew();

  @Query('SELECT * FROM CleaningServiceModel where staff is not null')
  Future<List<CleaningServiceModel>> getAOld();

  @Query('SELECT * FROM CleaningServiceModel where id = :id')
  Future<CleaningServiceModel?> getCSByID(int id);

  @update
  Future<int> updateCleaningService(CleaningServiceModel cs);
}
