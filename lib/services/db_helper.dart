import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/lugar.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'lugares_uide.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE lugares (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL,
            descripcion TEXT NOT NULL,
            lat REAL NOT NULL,
            lng REAL NOT NULL,
            favorito INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
    );
  }

  Future<int> insertLugar(Lugar lugar) async {
    final db = await database;
    return await db.insert('lugares', lugar.toMap());
  }

  Future<List<Lugar>> getLugares() async {
    final db = await database;
    final maps = await db.query('lugares');
    return maps.map((m) => Lugar.fromMap(m)).toList();
  }

  Future<int> updateLugar(Lugar lugar) async {
    final db = await database;
    return await db.update(
      'lugares',
      lugar.toMap(),
      where: 'id = ?',
      whereArgs: [lugar.id],
    );
  }
}
