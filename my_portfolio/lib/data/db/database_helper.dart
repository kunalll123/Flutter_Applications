import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Incrementing to v3 to force the app to create a fresh DB with the new column
    String path = join(await getDatabasesPath(), 'portfolio_v3.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE skills (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        category TEXT, 
        percentage INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE projects (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        techStack TEXT,
        githubUrl TEXT,
        category TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE experience (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        role TEXT,
        company TEXT,
        duration TEXT,
        period TEXT,
        responsibilities TEXT 
      )
    ''');

    await db.execute('''
      CREATE TABLE education (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        degree TEXT,
        institution TEXT,
        years TEXT,
        level TEXT -- ✅ ADDED: This fixes the "no column named level" error
      )
    ''');

    await db.execute('''
      CREATE TABLE certifications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        issuer TEXT,
        date TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE languages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        proficiency TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE awards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        issuer TEXT,
        date TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE profile (
        id INTEGER PRIMARY KEY, 
        name TEXT,
        headline TEXT,
        location TEXT,
        about TEXT,
        profileImagePath TEXT,
        email TEXT,
        phone TEXT,
        linkedIn TEXT,
        isOpenToWork INTEGER,
        showLanguages INTEGER DEFAULT 0,
        showVolunteer INTEGER DEFAULT 0,
        showAwards INTEGER DEFAULT 0
      )
    ''');
  }
}
