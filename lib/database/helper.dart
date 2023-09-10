import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _database;
  static const String _dbName = 'phone.db';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE phone(id INTEGER PRIMARY KEY, number TEXT)',
        );
      },
      version: 1,
    );
    return _database!;
  }

  Future<String?> getNumber() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('phone');
    if (maps.isEmpty) return null;
    return maps[0]['number'];
  }

  Future<void> updateNumber(String number) async {
    final db = await database;
    await db.insert(
        'phone',
        {
          'id': 1,
          'number': number,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('number updated to $number');
  }
}
