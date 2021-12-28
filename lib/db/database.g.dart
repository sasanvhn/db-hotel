// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  GuestDao? _guestDaoInstance;

  RoomTypeDao? _roomTypeDaoInstance;

  RoomStatusDao? _roomStatusDaoInstance;

  RoomDao? _roomDaoInstance;

  GeneralDao? _generalDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `People` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `gender` TEXT, `nationalId` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Bill` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `total` INTEGER NOT NULL, `status` INTEGER NOT NULL, `reservation` INTEGER NOT NULL, FOREIGN KEY (`reservation`) REFERENCES `Reservation` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `BookingStatus` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Guest` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `nationalId` TEXT NOT NULL, `gender` TEXT, `address` TEXT, `birthDate` TEXT, `password` TEXT NOT NULL, `phoneNumber` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `RestaurantCoffeeShop` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `type` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `RoomStatus` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `RoomType` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `numberOfBeds` INTEGER NOT NULL, `image` TEXT NOT NULL, `description` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Staff` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `startDate` TEXT NOT NULL, `salary` TEXT NOT NULL, `password` TEXT NOT NULL, `nationalId` TEXT NOT NULL, `name` TEXT NOT NULL, `email` TEXT NOT NULL, `role` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Food` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `price` INTEGER NOT NULL, `shopId` INTEGER NOT NULL, `type` INTEGER NOT NULL, `ingredients` TEXT, FOREIGN KEY (`shopId`) REFERENCES `RestaurantCoffeeShop` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Room` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `number` INTEGER NOT NULL, `floor` INTEGER NOT NULL, `price` INTEGER NOT NULL, `capacity` INTEGER NOT NULL, `type` INTEGER NOT NULL, `status` INTEGER NOT NULL, FOREIGN KEY (`type`) REFERENCES `RoomType` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, FOREIGN KEY (`status`) REFERENCES `RoomStatus` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Order` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `place` INTEGER NOT NULL, `reservationDetail` INTEGER NOT NULL, FOREIGN KEY (`reservationDetail`) REFERENCES `ReservationDetails` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FoodOrderRelation` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `food` INTEGER NOT NULL, `order` INTEGER NOT NULL, FOREIGN KEY (`food`) REFERENCES `Food` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`order`) REFERENCES `Order` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Reservation` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `reserveDate` TEXT NOT NULL, `checkInDate` TEXT, `checkOutDate` TEXT, `noNights` INTEGER, `bookingStatus` INTEGER NOT NULL, `staff` INTEGER NOT NULL, `bill` INTEGER, `guest` INTEGER NOT NULL, FOREIGN KEY (`bookingStatus`) REFERENCES `BookingStatus` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`staff`) REFERENCES `Staff` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`bill`) REFERENCES `Bill` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`guest`) REFERENCES `Guest` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ReservationDetails` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `rate` INTEGER, `extraFacilities` TEXT, `room` INTEGER NOT NULL, `reservation` INTEGER NOT NULL, FOREIGN KEY (`room`) REFERENCES `Room` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CleaningServiceModel` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date` TEXT NOT NULL, `time` TEXT, `description` TEXT, `staff` INTEGER, `reservationDetail` INTEGER NOT NULL, FOREIGN KEY (`staff`) REFERENCES `Staff` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`reservationDetail`) REFERENCES `ReservationDetails` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  GuestDao get guestDao {
    return _guestDaoInstance ??= _$GuestDao(database, changeListener);
  }

  @override
  RoomTypeDao get roomTypeDao {
    return _roomTypeDaoInstance ??= _$RoomTypeDao(database, changeListener);
  }

  @override
  RoomStatusDao get roomStatusDao {
    return _roomStatusDaoInstance ??= _$RoomStatusDao(database, changeListener);
  }

  @override
  RoomDao get roomDao {
    return _roomDaoInstance ??= _$RoomDao(database, changeListener);
  }

  @override
  GeneralDao get generalDao {
    return _generalDaoInstance ??= _$GeneralDao(database, changeListener);
  }
}

class _$GuestDao extends GuestDao {
  _$GuestDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _guestInsertionAdapter = InsertionAdapter(
            database,
            'Guest',
            (Guest item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'nationalId': item.nationalId,
                  'gender': item.gender,
                  'address': item.address,
                  'birthDate': item.birthDate,
                  'password': item.password,
                  'phoneNumber': item.phoneNumber
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Guest> _guestInsertionAdapter;

  @override
  Future<Guest?> getGuest(String nationalID, String password) async {
    return _queryAdapter.query(
        'SELECT * FROM Guest where password = ?2 and nationalID = ?1',
        mapper: (Map<String, Object?> row) => Guest(
            name: row['name'] as String,
            nationalId: row['nationalId'] as String,
            gender: row['gender'] as String?,
            address: row['address'] as String?,
            birthDate: row['birthDate'] as String?,
            password: row['password'] as String,
            phoneNumber: row['phoneNumber'] as String),
        arguments: [nationalID, password]);
  }

  @override
  Future<Guest?> getGuestByNationalID(String nationalID) async {
    return _queryAdapter.query('SELECT * FROM Guest where nationalID = ?1',
        mapper: (Map<String, Object?> row) => Guest(
            name: row['name'] as String,
            nationalId: row['nationalId'] as String,
            gender: row['gender'] as String?,
            address: row['address'] as String?,
            birthDate: row['birthDate'] as String?,
            password: row['password'] as String,
            phoneNumber: row['phoneNumber'] as String),
        arguments: [nationalID]);
  }

  @override
  Future<void> insertGuest(Guest guest) async {
    await _guestInsertionAdapter.insert(guest, OnConflictStrategy.abort);
  }
}

class _$RoomTypeDao extends RoomTypeDao {
  _$RoomTypeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _roomTypeInsertionAdapter = InsertionAdapter(
            database,
            'RoomType',
            (RoomType item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'numberOfBeds': item.numberOfBeds,
                  'image': item.image,
                  'description': item.description
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RoomType> _roomTypeInsertionAdapter;

  @override
  Future<RoomType?> getRoomTypeByName(String name) async {
    return _queryAdapter.query('SELECT * FROM RoomType where name = ?1',
        mapper: (Map<String, Object?> row) => RoomType(
            name: row['name'] as String,
            numberOfBeds: row['numberOfBeds'] as int,
            image: row['image'] as String,
            description: row['description'] as String),
        arguments: [name]);
  }

  @override
  Future<void> insertRoomType(RoomType roomType) async {
    await _roomTypeInsertionAdapter.insert(roomType, OnConflictStrategy.abort);
  }
}

class _$RoomStatusDao extends RoomStatusDao {
  _$RoomStatusDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _roomStatusInsertionAdapter = InsertionAdapter(
            database,
            'RoomStatus',
            (RoomStatus item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RoomStatus> _roomStatusInsertionAdapter;

  @override
  Future<RoomStatus?> getRoomStatusByName(String name) async {
    return _queryAdapter.query('SELECT * FROM RoomStatus where name = ?1',
        mapper: (Map<String, Object?> row) =>
            RoomStatus(name: row['name'] as String),
        arguments: [name]);
  }

  @override
  Future<void> insertRoomStatus(RoomStatus roomStatus) async {
    await _roomStatusInsertionAdapter.insert(
        roomStatus, OnConflictStrategy.abort);
  }
}

class _$RoomDao extends RoomDao {
  _$RoomDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _roomInsertionAdapter = InsertionAdapter(
            database,
            'Room',
            (Room item) => <String, Object?>{
                  'id': item.id,
                  'number': item.number,
                  'floor': item.floor,
                  'price': item.price,
                  'capacity': item.capacity,
                  'type': item.type,
                  'status': item.status
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Room> _roomInsertionAdapter;

  @override
  Future<Room?> getAllRooms() async {
    return _queryAdapter.query('SELECT * FROM Room',
        mapper: (Map<String, Object?> row) => Room(
            number: row['number'] as int,
            floor: row['floor'] as int,
            price: row['price'] as int,
            capacity: row['capacity'] as int,
            type: row['type'] as int,
            status: row['status'] as int));
  }

  @override
  Future<Room?> getRoomByID(int id) async {
    return _queryAdapter.query('SELECT * FROM Room where id = ?1',
        mapper: (Map<String, Object?> row) => Room(
            number: row['number'] as int,
            floor: row['floor'] as int,
            price: row['price'] as int,
            capacity: row['capacity'] as int,
            type: row['type'] as int,
            status: row['status'] as int),
        arguments: [id]);
  }

  @override
  Future<Room?> getRoomsByStatusID(int statusID) async {
    return _queryAdapter.query('SELECT * FROM Room where status = ?1',
        mapper: (Map<String, Object?> row) => Room(
            number: row['number'] as int,
            floor: row['floor'] as int,
            price: row['price'] as int,
            capacity: row['capacity'] as int,
            type: row['type'] as int,
            status: row['status'] as int),
        arguments: [statusID]);
  }

  @override
  Future<Room?> getRoomsByTypeID(int typeID) async {
    return _queryAdapter.query('SELECT * FROM Room where type = ?1',
        mapper: (Map<String, Object?> row) => Room(
            number: row['number'] as int,
            floor: row['floor'] as int,
            price: row['price'] as int,
            capacity: row['capacity'] as int,
            type: row['type'] as int,
            status: row['status'] as int),
        arguments: [typeID]);
  }

  @override
  Future<Room?> getRoomsByTypeIDAndStatusID(int typeID, int statusID) async {
    return _queryAdapter.query(
        'SELECT * FROM Room where type = ?1 and status = ?2',
        mapper: (Map<String, Object?> row) => Room(
            number: row['number'] as int,
            floor: row['floor'] as int,
            price: row['price'] as int,
            capacity: row['capacity'] as int,
            type: row['type'] as int,
            status: row['status'] as int),
        arguments: [typeID, statusID]);
  }

  @override
  Future<void> insertRoom(Room room) async {
    await _roomInsertionAdapter.insert(room, OnConflictStrategy.abort);
  }
}

class _$GeneralDao extends GeneralDao {
  _$GeneralDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<void> deleteSome() async {
    await _queryAdapter
        .queryNoReturn('DELETE * FROM RoomStatus, RoomType, Room, Guest');
  }
}
