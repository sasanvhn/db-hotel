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

  BookingStatusDao? _bookingStatusDaoInstance;

  ReservationDao? _reservationDaoInstance;

  StaffDao? _staffDaoInstance;

  ReservationDetailDao? _reservationDetailDaoInstance;

  CleaningServiceDao? _cleaningServiceDaoInstance;

  PeopleDao? _peopleDaoInstance;

  RestaurantDao? _restaurantDaoInstance;

  FoodDao? _foodDaoInstance;

  OrderDao? _orderDaoInstance;

  FoodOrderDao? _foodOrderRelationDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `FoodOrderRelation` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `food` INTEGER NOT NULL, `order` INTEGER NOT NULL, FOREIGN KEY (`food`) REFERENCES `Food` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`order`) REFERENCES `Order` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Reservation` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `reserveDate` TEXT NOT NULL, `checkInDate` TEXT, `checkOutDate` TEXT, `noNights` INTEGER, `bookingStatus` INTEGER NOT NULL, `staff` INTEGER, `bill` INTEGER, `guest` INTEGER NOT NULL, FOREIGN KEY (`bookingStatus`) REFERENCES `BookingStatus` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`staff`) REFERENCES `Staff` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`bill`) REFERENCES `Bill` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`guest`) REFERENCES `Guest` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
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

  @override
  BookingStatusDao get bookingStatusDao {
    return _bookingStatusDaoInstance ??=
        _$BookingStatusDao(database, changeListener);
  }

  @override
  ReservationDao get reservationDao {
    return _reservationDaoInstance ??=
        _$ReservationDao(database, changeListener);
  }

  @override
  StaffDao get staffDao {
    return _staffDaoInstance ??= _$StaffDao(database, changeListener);
  }

  @override
  ReservationDetailDao get reservationDetailDao {
    return _reservationDetailDaoInstance ??=
        _$ReservationDetailDao(database, changeListener);
  }

  @override
  CleaningServiceDao get cleaningServiceDao {
    return _cleaningServiceDaoInstance ??=
        _$CleaningServiceDao(database, changeListener);
  }

  @override
  PeopleDao get peopleDao {
    return _peopleDaoInstance ??= _$PeopleDao(database, changeListener);
  }

  @override
  RestaurantDao get restaurantDao {
    return _restaurantDaoInstance ??= _$RestaurantDao(database, changeListener);
  }

  @override
  FoodDao get foodDao {
    return _foodDaoInstance ??= _$FoodDao(database, changeListener);
  }

  @override
  OrderDao get orderDao {
    return _orderDaoInstance ??= _$OrderDao(database, changeListener);
  }

  @override
  FoodOrderDao get foodOrderRelationDao {
    return _foodOrderRelationDaoInstance ??=
        _$FoodOrderDao(database, changeListener);
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
            id: row['id'] as int?,
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
            id: row['id'] as int?,
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
            id: row['id'] as int?,
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
            RoomStatus(id: row['id'] as int?, name: row['name'] as String),
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
                }),
        _roomUpdateAdapter = UpdateAdapter(
            database,
            'Room',
            ['id'],
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

  final UpdateAdapter<Room> _roomUpdateAdapter;

  @override
  Future<List<Room>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM Room',
        mapper: (Map<String, Object?> row) => Room(
            id: row['id'] as int?,
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
            id: row['id'] as int?,
            number: row['number'] as int,
            floor: row['floor'] as int,
            price: row['price'] as int,
            capacity: row['capacity'] as int,
            type: row['type'] as int,
            status: row['status'] as int),
        arguments: [id]);
  }

  @override
  Future<List<Room?>?> getRoomsByStatusID(int statusID) async {
    return _queryAdapter.queryList('SELECT * FROM Room where status = ?1',
        mapper: (Map<String, Object?> row) => Room(
            id: row['id'] as int?,
            number: row['number'] as int,
            floor: row['floor'] as int,
            price: row['price'] as int,
            capacity: row['capacity'] as int,
            type: row['type'] as int,
            status: row['status'] as int),
        arguments: [statusID]);
  }

  @override
  Future<List<Room?>?> getRoomsByTypeID(int typeID) async {
    return _queryAdapter.queryList('SELECT * FROM Room where type = ?1',
        mapper: (Map<String, Object?> row) => Room(
            id: row['id'] as int?,
            number: row['number'] as int,
            floor: row['floor'] as int,
            price: row['price'] as int,
            capacity: row['capacity'] as int,
            type: row['type'] as int,
            status: row['status'] as int),
        arguments: [typeID]);
  }

  @override
  Future<List<Room?>?> getRoomsByTypeIDAndStatusID(
      int typeID, int statusID) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Room where type = ?1 and status = ?2',
        mapper: (Map<String, Object?> row) => Room(
            id: row['id'] as int?,
            number: row['number'] as int,
            floor: row['floor'] as int,
            price: row['price'] as int,
            capacity: row['capacity'] as int,
            type: row['type'] as int,
            status: row['status'] as int),
        arguments: [typeID, statusID]);
  }

  @override
  Future<List<Room>> getRoomsByReservationID(int rid) async {
    return _queryAdapter.queryList(
        'SELECT * from Room where id in (SELECT room from ReservationDetails where reservation = ?1)',
        mapper: (Map<String, Object?> row) => Room(id: row['id'] as int?, number: row['number'] as int, floor: row['floor'] as int, price: row['price'] as int, capacity: row['capacity'] as int, type: row['type'] as int, status: row['status'] as int),
        arguments: [rid]);
  }

  @override
  Future<void> insertRoom(Room room) async {
    await _roomInsertionAdapter.insert(room, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateRoom(Room room) async {
    await _roomUpdateAdapter.update(room, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateRooms(List<Room> rooms) {
    return _roomUpdateAdapter.updateListAndReturnChangedRows(
        rooms, OnConflictStrategy.abort);
  }
}

class _$GeneralDao extends GeneralDao {
  _$GeneralDao(this.database, this.changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;
}

class _$BookingStatusDao extends BookingStatusDao {
  _$BookingStatusDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _bookingStatusInsertionAdapter = InsertionAdapter(
            database,
            'BookingStatus',
            (BookingStatus item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BookingStatus> _bookingStatusInsertionAdapter;

  @override
  Future<BookingStatus?> getBookingStatusByName(String name) async {
    return _queryAdapter.query('SELECT * FROM BookingStatus where name = ?1',
        mapper: (Map<String, Object?> row) =>
            BookingStatus(id: row['id'] as int?, name: row['name'] as String),
        arguments: [name]);
  }

  @override
  Future<BookingStatus?> getBookingStatusByID(int id) async {
    return _queryAdapter.query('SELECT * FROM BookingStatus where id = ?1',
        mapper: (Map<String, Object?> row) =>
            BookingStatus(id: row['id'] as int?, name: row['name'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertBookingStatus(BookingStatus roomStatus) async {
    await _bookingStatusInsertionAdapter.insert(
        roomStatus, OnConflictStrategy.abort);
  }
}

class _$ReservationDao extends ReservationDao {
  _$ReservationDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _reservationInsertionAdapter = InsertionAdapter(
            database,
            'Reservation',
            (Reservation item) => <String, Object?>{
                  'id': item.id,
                  'reserveDate': item.reserveDate,
                  'checkInDate': item.checkInDate,
                  'checkOutDate': item.checkOutDate,
                  'noNights': item.noNights,
                  'bookingStatus': item.bookingStatus,
                  'staff': item.staff,
                  'bill': item.bill,
                  'guest': item.guest
                }),
        _reservationUpdateAdapter = UpdateAdapter(
            database,
            'Reservation',
            ['id'],
            (Reservation item) => <String, Object?>{
                  'id': item.id,
                  'reserveDate': item.reserveDate,
                  'checkInDate': item.checkInDate,
                  'checkOutDate': item.checkOutDate,
                  'noNights': item.noNights,
                  'bookingStatus': item.bookingStatus,
                  'staff': item.staff,
                  'bill': item.bill,
                  'guest': item.guest
                }),
        _reservationDeletionAdapter = DeletionAdapter(
            database,
            'Reservation',
            ['id'],
            (Reservation item) => <String, Object?>{
                  'id': item.id,
                  'reserveDate': item.reserveDate,
                  'checkInDate': item.checkInDate,
                  'checkOutDate': item.checkOutDate,
                  'noNights': item.noNights,
                  'bookingStatus': item.bookingStatus,
                  'staff': item.staff,
                  'bill': item.bill,
                  'guest': item.guest
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Reservation> _reservationInsertionAdapter;

  final UpdateAdapter<Reservation> _reservationUpdateAdapter;

  final DeletionAdapter<Reservation> _reservationDeletionAdapter;

  @override
  Future<Reservation?> getReservationByDetails(
      int guestID, String reserveDate, String checkInDate, int noNights) async {
    return _queryAdapter.query(
        'SELECT * FROM Reservation where guest = ?1 and reserveDate = ?2 and checkInDate = ?3 and noNights = ?4',
        mapper: (Map<String, Object?> row) => Reservation(id: row['id'] as int?, guest: row['guest'] as int, reserveDate: row['reserveDate'] as String, checkInDate: row['checkInDate'] as String?, checkOutDate: row['checkOutDate'] as String?, noNights: row['noNights'] as int?, bookingStatus: row['bookingStatus'] as int, staff: row['staff'] as int?, bill: row['bill'] as int?),
        arguments: [guestID, reserveDate, checkInDate, noNights]);
  }

  @override
  Future<Reservation?> getReservationByID(int id) async {
    return _queryAdapter.query('SELECT * FROM Reservation where id = ?1',
        mapper: (Map<String, Object?> row) => Reservation(
            id: row['id'] as int?,
            guest: row['guest'] as int,
            reserveDate: row['reserveDate'] as String,
            checkInDate: row['checkInDate'] as String?,
            checkOutDate: row['checkOutDate'] as String?,
            noNights: row['noNights'] as int?,
            bookingStatus: row['bookingStatus'] as int,
            staff: row['staff'] as int?,
            bill: row['bill'] as int?),
        arguments: [id]);
  }

  @override
  Future<List<Reservation>?> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM Reservation',
        mapper: (Map<String, Object?> row) => Reservation(
            id: row['id'] as int?,
            guest: row['guest'] as int,
            reserveDate: row['reserveDate'] as String,
            checkInDate: row['checkInDate'] as String?,
            checkOutDate: row['checkOutDate'] as String?,
            noNights: row['noNights'] as int?,
            bookingStatus: row['bookingStatus'] as int,
            staff: row['staff'] as int?,
            bill: row['bill'] as int?));
  }

  @override
  Future<List<Reservation>> getReservationByGuestID(int id) async {
    return _queryAdapter.queryList('SELECT * FROM Reservation where guest = ?1',
        mapper: (Map<String, Object?> row) => Reservation(
            id: row['id'] as int?,
            guest: row['guest'] as int,
            reserveDate: row['reserveDate'] as String,
            checkInDate: row['checkInDate'] as String?,
            checkOutDate: row['checkOutDate'] as String?,
            noNights: row['noNights'] as int?,
            bookingStatus: row['bookingStatus'] as int,
            staff: row['staff'] as int?,
            bill: row['bill'] as int?),
        arguments: [id]);
  }

  @override
  Future<List<Reservation>> getReservationByGuestIDAndStatus(
      int id, int status) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Reservation where guest = ?1 and bookingStatus = ?2',
        mapper: (Map<String, Object?> row) => Reservation(
            id: row['id'] as int?,
            guest: row['guest'] as int,
            reserveDate: row['reserveDate'] as String,
            checkInDate: row['checkInDate'] as String?,
            checkOutDate: row['checkOutDate'] as String?,
            noNights: row['noNights'] as int?,
            bookingStatus: row['bookingStatus'] as int,
            staff: row['staff'] as int?,
            bill: row['bill'] as int?),
        arguments: [id, status]);
  }

  @override
  Future<int> insertReservation(Reservation reservation) {
    return _reservationInsertionAdapter.insertAndReturnId(
        reservation, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateReservation(Reservation reservation) async {
    await _reservationUpdateAdapter.update(
        reservation, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteReservation(Reservation reservation) async {
    await _reservationDeletionAdapter.delete(reservation);
  }

  @override
  Future<int> deleteReservations(List<Reservation> reservations) {
    return _reservationDeletionAdapter
        .deleteListAndReturnChangedRows(reservations);
  }
}

class _$StaffDao extends StaffDao {
  _$StaffDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _staffInsertionAdapter = InsertionAdapter(
            database,
            'Staff',
            (Staff item) => <String, Object?>{
                  'id': item.id,
                  'startDate': item.startDate,
                  'salary': item.salary,
                  'password': item.password,
                  'nationalId': item.nationalId,
                  'name': item.name,
                  'email': item.email,
                  'role': item.role
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Staff> _staffInsertionAdapter;

  @override
  Future<Staff?> getStaffByID(int id) async {
    return _queryAdapter.query('SELECT * FROM Staff where id = ?1',
        mapper: (Map<String, Object?> row) => Staff(
            id: row['id'] as int?,
            startDate: row['startDate'] as String,
            salary: row['salary'] as String,
            password: row['password'] as String,
            name: row['name'] as String,
            nationalId: row['nationalId'] as String,
            email: row['email'] as String,
            role: row['role'] as int),
        arguments: [id]);
  }

  @override
  Future<Staff?> getStaff(String nationalID, String password) async {
    return _queryAdapter.query(
        'SELECT * FROM Staff where password = ?2 and nationalID = ?1',
        mapper: (Map<String, Object?> row) => Staff(
            id: row['id'] as int?,
            startDate: row['startDate'] as String,
            salary: row['salary'] as String,
            password: row['password'] as String,
            name: row['name'] as String,
            nationalId: row['nationalId'] as String,
            email: row['email'] as String,
            role: row['role'] as int),
        arguments: [nationalID, password]);
  }

  @override
  Future<void> insertStaff(Staff staff) async {
    await _staffInsertionAdapter.insert(staff, OnConflictStrategy.abort);
  }
}

class _$ReservationDetailDao extends ReservationDetailDao {
  _$ReservationDetailDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _reservationDetailsInsertionAdapter = InsertionAdapter(
            database,
            'ReservationDetails',
            (ReservationDetails item) => <String, Object?>{
                  'id': item.id,
                  'rate': item.rate,
                  'extraFacilities': item.extraFacilities,
                  'room': item.room,
                  'reservation': item.reservation
                }),
        _reservationDetailsDeletionAdapter = DeletionAdapter(
            database,
            'ReservationDetails',
            ['id'],
            (ReservationDetails item) => <String, Object?>{
                  'id': item.id,
                  'rate': item.rate,
                  'extraFacilities': item.extraFacilities,
                  'room': item.room,
                  'reservation': item.reservation
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ReservationDetails>
      _reservationDetailsInsertionAdapter;

  final DeletionAdapter<ReservationDetails> _reservationDetailsDeletionAdapter;

  @override
  Future<List<ReservationDetails>?> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM ReservationDetails',
        mapper: (Map<String, Object?> row) => ReservationDetails(
            id: row['id'] as int?,
            room: row['room'] as int,
            reservation: row['reservation'] as int,
            rate: row['rate'] as int?,
            extraFacilities: row['extraFacilities'] as String?));
  }

  @override
  Future<ReservationDetails?> getReservationDetailByResAndRoom(
      int res, int room) async {
    return _queryAdapter.query(
        'SELECT * FROM ReservationDetails where reservation = ?1 AND room = ?2',
        mapper: (Map<String, Object?> row) => ReservationDetails(
            id: row['id'] as int?,
            room: row['room'] as int,
            reservation: row['reservation'] as int,
            rate: row['rate'] as int?,
            extraFacilities: row['extraFacilities'] as String?),
        arguments: [res, room]);
  }

  @override
  Future<List<ReservationDetails>> getRoomsIDsByResID(int res) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ReservationDetails where reservation = ?1',
        mapper: (Map<String, Object?> row) => ReservationDetails(
            id: row['id'] as int?,
            room: row['room'] as int,
            reservation: row['reservation'] as int,
            rate: row['rate'] as int?,
            extraFacilities: row['extraFacilities'] as String?),
        arguments: [res]);
  }

  @override
  Future<void> insertReservationDetail(
      ReservationDetails reservationDetail) async {
    await _reservationDetailsInsertionAdapter.insert(
        reservationDetail, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteReservationDetail(
      ReservationDetails reservationDetails) async {
    await _reservationDetailsDeletionAdapter.delete(reservationDetails);
  }

  @override
  Future<int> deleteReservationDetails(
      List<ReservationDetails> reservationDetails) {
    return _reservationDetailsDeletionAdapter
        .deleteListAndReturnChangedRows(reservationDetails);
  }
}

class _$CleaningServiceDao extends CleaningServiceDao {
  _$CleaningServiceDao(this.database, this.changeListener)
      : _cleaningServiceModelInsertionAdapter = InsertionAdapter(
            database,
            'CleaningServiceModel',
            (CleaningServiceModel item) => <String, Object?>{
                  'id': item.id,
                  'date': item.date,
                  'time': item.time,
                  'description': item.description,
                  'staff': item.staff,
                  'reservationDetail': item.reservationDetail
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<CleaningServiceModel>
      _cleaningServiceModelInsertionAdapter;

  @override
  Future<void> insertCleaningService(
      CleaningServiceModel cleaningService) async {
    await _cleaningServiceModelInsertionAdapter.insert(
        cleaningService, OnConflictStrategy.abort);
  }
}

class _$PeopleDao extends PeopleDao {
  _$PeopleDao(this.database, this.changeListener)
      : _peopleInsertionAdapter = InsertionAdapter(
            database,
            'People',
            (People item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'gender': item.gender,
                  'nationalId': item.nationalId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<People> _peopleInsertionAdapter;

  @override
  Future<void> insertGuest(People p) async {
    await _peopleInsertionAdapter.insert(p, OnConflictStrategy.abort);
  }
}

class _$RestaurantDao extends RestaurantDao {
  _$RestaurantDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _restaurantCoffeeShopInsertionAdapter = InsertionAdapter(
            database,
            'RestaurantCoffeeShop',
            (RestaurantCoffeeShop item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'type': item.type
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RestaurantCoffeeShop>
      _restaurantCoffeeShopInsertionAdapter;

  @override
  Future<List<RestaurantCoffeeShop>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM RestaurantCoffeeShop',
        mapper: (Map<String, Object?> row) => RestaurantCoffeeShop(
            id: row['id'] as int?,
            name: row['name'] as String,
            type: row['type'] as int));
  }

  @override
  Future<List<RestaurantCoffeeShop>> getRestaurantsByType(int t) async {
    return _queryAdapter.queryList(
        'SELECT * FROM RestaurantCoffeeShop where type = ?1',
        mapper: (Map<String, Object?> row) => RestaurantCoffeeShop(
            id: row['id'] as int?,
            name: row['name'] as String,
            type: row['type'] as int),
        arguments: [t]);
  }

  @override
  Future<RestaurantCoffeeShop?> getRestaurantByName(String name) async {
    return _queryAdapter.query(
        'SELECT * FROM RestaurantCoffeeShop where name = ?1',
        mapper: (Map<String, Object?> row) => RestaurantCoffeeShop(
            id: row['id'] as int?,
            name: row['name'] as String,
            type: row['type'] as int),
        arguments: [name]);
  }

  @override
  Future<void> insertRestaurant(RestaurantCoffeeShop r) async {
    await _restaurantCoffeeShopInsertionAdapter.insert(
        r, OnConflictStrategy.abort);
  }
}

class _$FoodDao extends FoodDao {
  _$FoodDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _foodInsertionAdapter = InsertionAdapter(
            database,
            'Food',
            (Food item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'price': item.price,
                  'shopId': item.shopId,
                  'type': item.type,
                  'ingredients': item.ingredients
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Food> _foodInsertionAdapter;

  @override
  Future<List<Food>> getFoodByShopID(int shopID) async {
    return _queryAdapter.queryList('SELECT * FROM Food where shopId = ?1',
        mapper: (Map<String, Object?> row) => Food(
            id: row['id'] as int?,
            name: row['name'] as String,
            price: row['price'] as int,
            shopId: row['shopId'] as int,
            type: row['type'] as int,
            ingredients: row['ingredients'] as String?),
        arguments: [shopID]);
  }

  @override
  Future<List<Food>> getFoodByShopIDAndType(int shopID, int t) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Food where shopId = ?1 AND type= ?2',
        mapper: (Map<String, Object?> row) => Food(
            id: row['id'] as int?,
            name: row['name'] as String,
            price: row['price'] as int,
            shopId: row['shopId'] as int,
            type: row['type'] as int,
            ingredients: row['ingredients'] as String?),
        arguments: [shopID, t]);
  }

  @override
  Future<List<Food>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM Food',
        mapper: (Map<String, Object?> row) => Food(
            id: row['id'] as int?,
            name: row['name'] as String,
            price: row['price'] as int,
            shopId: row['shopId'] as int,
            type: row['type'] as int,
            ingredients: row['ingredients'] as String?));
  }

  @override
  Future<Food?> getFoodByID(int id) async {
    return _queryAdapter.query('SELECT * FROM Food where id = ?1',
        mapper: (Map<String, Object?> row) => Food(
            id: row['id'] as int?,
            name: row['name'] as String,
            price: row['price'] as int,
            shopId: row['shopId'] as int,
            type: row['type'] as int,
            ingredients: row['ingredients'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> insertFood(Food f) async {
    await _foodInsertionAdapter.insert(f, OnConflictStrategy.abort);
  }
}

class _$OrderDao extends OrderDao {
  _$OrderDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _orderInsertionAdapter = InsertionAdapter(
            database,
            'Order',
            (Order item) => <String, Object?>{
                  'id': item.id,
                  'place': item.place,
                  'reservationDetail': item.reservationDetail
                }),
        _orderDeletionAdapter = DeletionAdapter(
            database,
            'Order',
            ['id'],
            (Order item) => <String, Object?>{
                  'id': item.id,
                  'place': item.place,
                  'reservationDetail': item.reservationDetail
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Order> _orderInsertionAdapter;

  final DeletionAdapter<Order> _orderDeletionAdapter;

  @override
  Future<List<Order>> getOrdersByRDID(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM \"Order\" where reservationDetail = ?1',
        mapper: (Map<String, Object?> row) => Order(
            id: row['id'] as int?,
            place: row['place'] as int,
            reservationDetail: row['reservationDetail'] as int),
        arguments: [id]);
  }

  @override
  Future<List<Order>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM \"Order\"',
        mapper: (Map<String, Object?> row) => Order(
            id: row['id'] as int?,
            place: row['place'] as int,
            reservationDetail: row['reservationDetail'] as int));
  }

  @override
  Future<int> insertOrder(Order r) {
    return _orderInsertionAdapter.insertAndReturnId(
        r, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteOrders(List<Order> orders) {
    return _orderDeletionAdapter.deleteListAndReturnChangedRows(orders);
  }
}

class _$FoodOrderDao extends FoodOrderDao {
  _$FoodOrderDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _foodOrderRelationInsertionAdapter = InsertionAdapter(
            database,
            'FoodOrderRelation',
            (FoodOrderRelation item) => <String, Object?>{
                  'id': item.id,
                  'food': item.food,
                  'order': item.order
                }),
        _foodOrderRelationDeletionAdapter = DeletionAdapter(
            database,
            'FoodOrderRelation',
            ['id'],
            (FoodOrderRelation item) => <String, Object?>{
                  'id': item.id,
                  'food': item.food,
                  'order': item.order
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FoodOrderRelation> _foodOrderRelationInsertionAdapter;

  final DeletionAdapter<FoodOrderRelation> _foodOrderRelationDeletionAdapter;

  @override
  Future<Food?> getFoodsByOrderID(int order) async {
    return _queryAdapter.query(
        'SELECT * FROM Food where id = (SELECT food FROM FoodOrderRelation where order = ?1)',
        mapper: (Map<String, Object?> row) => Food(id: row['id'] as int?, name: row['name'] as String, price: row['price'] as int, shopId: row['shopId'] as int, type: row['type'] as int, ingredients: row['ingredients'] as String?),
        arguments: [order]);
  }

  @override
  Future<List<FoodOrderRelation>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM FoodOrderRelation',
        mapper: (Map<String, Object?> row) => FoodOrderRelation(
            id: row['id'] as int?,
            food: row['food'] as int,
            order: row['order'] as int));
  }

  @override
  Future<List<FoodOrderRelation>> getFoodOrderRelationByOrderID(int a) async {
    return _queryAdapter.queryList(
        'SELECT * FROM FoodOrderRelation where \"order\" = ?1',
        mapper: (Map<String, Object?> row) => FoodOrderRelation(
            id: row['id'] as int?,
            food: row['food'] as int,
            order: row['order'] as int),
        arguments: [a]);
  }

  @override
  Future<void> insertFoodOrderRelation(FoodOrderRelation foodOrder) async {
    await _foodOrderRelationInsertionAdapter.insert(
        foodOrder, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteFoodOrderRelations(List<FoodOrderRelation> a) {
    return _foodOrderRelationDeletionAdapter.deleteListAndReturnChangedRows(a);
  }
}
