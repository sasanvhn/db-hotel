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
            'CREATE TABLE IF NOT EXISTS `Bill` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `total` INTEGER NOT NULL, `status` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `BookingStatus` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Guest` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `nationalId` TEXT NOT NULL, `gender` TEXT, `address` TEXT NOT NULL, `birthDate` TEXT NOT NULL, `password` TEXT NOT NULL, `phoneNumber` TEXT NOT NULL)');
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

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }
}
