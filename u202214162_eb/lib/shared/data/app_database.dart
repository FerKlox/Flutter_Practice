import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  final int version = 1;
  final String databaseName = 'app_database.db';
  final String favoritesTableName = 'favorites';

  Database? _db;

  Future<Database> openDb() async {
    _db ??= await openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: version,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $favoritesTableName(
            id INTEGER PRIMARY KEY,
            sol INTEGER,
            camera TEXT,
            img_src TEXT,
            earth_date TEXT,
            rover TEXT
          )
        ''');
      },
    );
    return _db as Database;
  }
}