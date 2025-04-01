import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/password_data.dart';

class DatabaseHelper{
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('passwords.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE passwords (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        websiteName TEXT NOT NULL,
        userId TEXT NOT NULL,
        websiteLink TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');
  }
  Future<int> insertPassword(PasswordData password) async {
    final db = await instance.database;
    return await db.insert('passwords', password.toMap());
  }

  Future<List<PasswordData>> getAllPasswords() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('passwords');

    return maps.map((map) => PasswordData.fromMap(map)).toList();
  }

  Future<void> deletePassword(int id) async {
    final db = await instance.database;
    await db.delete('passwords', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updatePassword(PasswordData password) async {
    final db = await instance.database;
    return await db.update(
      'passwords',
      password.toMap(),
      where: 'id = ?',
      whereArgs: [password.id],
    );
  }
}