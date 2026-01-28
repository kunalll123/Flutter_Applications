import 'package:sqflite/sqflite.dart';
import '../db/database_helper.dart';
import '../models/education_model.dart';

class EducationDB {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertEducation(EducationModel edu) async {
    final db = await dbHelper.database;
    return await db.insert('education', edu.toMap());
  }

  Future<List<EducationModel>> getEducations() async {
    final db = await dbHelper.database;
    final maps = await db.query('education');
    return maps.map((e) => EducationModel.fromMap(e)).toList();
  }

  Future<int> updateEducation(EducationModel edu) async {
    final db = await dbHelper.database;
    return await db.update(
      'education',
      edu.toMap(),
      where: 'id = ?',
      whereArgs: [edu.id],
    );
  }

  Future<int> deleteEducation(int id) async {
    final db = await dbHelper.database;
    return await db.delete('education', where: 'id = ?', whereArgs: [id]);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE education (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      institution TEXT,
      degree TEXT,
      years TEXT,
      level TEXT -- ✅ ADD THIS COLUMN
    )
  ''');
  }
}
