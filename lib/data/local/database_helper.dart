import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'favorites.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productId INTEGER NOT NULL,
            timestamp INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> addFavorite(int productId) async {
    final db = await database;
    await db.insert(
      'favorites',
      {
        'productId': productId,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFavorite(int productId) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  Future<List<int>> getFavoriteIds() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (i) => maps[i]['productId'] as int);
  }

  Future<bool> isFavorite(int productId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'favorites',
      where: 'productId = ?',
      whereArgs: [productId],
    );
    return maps.isNotEmpty;
  }
}