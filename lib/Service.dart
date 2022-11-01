import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE test(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT NOT NULL, nama TEXT NOT NULL, password TEXT NOT NULL, nomor_telepon TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }
}
