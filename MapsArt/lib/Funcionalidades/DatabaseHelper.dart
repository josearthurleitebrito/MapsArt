import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 2, // Atualize o número da versão
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE users(matricula TEXT PRIMARY KEY, nome TEXT, email TEXT, senha TEXT)',
        );
        db.execute(
          'CREATE TABLE comments(id INTEGER PRIMARY KEY AUTOINCREMENT, matricula TEXT, comentario TEXT, FOREIGN KEY(matricula) REFERENCES users(matricula))',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          db.execute(
            'CREATE TABLE comments(id INTEGER PRIMARY KEY AUTOINCREMENT, matricula TEXT, comentario TEXT, FOREIGN KEY(matricula) REFERENCES users(matricula))',
          );
        }
        // Adicione outras migrações necessárias para versões futuras
      },
    );
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      throw Exception('No user found');
    }
  }

  Future<void> updateUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.update(
      'users',
      user,
      where: 'matricula = ?',
      whereArgs: [user['matricula']],
    );
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert(
      'users',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertComment(String matricula, String comentario) async {
    final db = await database;
    await db.insert(
      'comments',
      {'matricula': matricula, 'comentario': comentario},
    );
  }

  Future<List<Map<String, dynamic>>> getComments() async {
    final db = await database;
    return await db.query('comments');
  }

  Future<Map<String, dynamic>> getUser(String matricula) async { // Ajuste para remover a senha
  final db = await database;
  final List<Map<String, dynamic>> result = await db.query(
    'users',
    where: 'matricula = ?',
    whereArgs: [matricula],
  );
  return result.isNotEmpty ? result.first : {};
}
}
