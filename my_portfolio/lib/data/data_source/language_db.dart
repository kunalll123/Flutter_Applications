import 'package:sqflite/sqflite.dart';
import '../db/database_helper.dart';
import '../models/language_model.dart';

class LanguageDB {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertLanguage(LanguageModel lang) async {
    final db = await dbHelper.database;
    return await db.insert('languages', lang.toMap());
  }

  Future<List<LanguageModel>> getLanguages() async {
    final db = await dbHelper.database;
    final maps = await db.query('languages');
    return maps.map((e) => LanguageModel.fromMap(e)).toList();
  }

  Future<int> deleteLanguage(int id) async {
    final db = await dbHelper.database;
    return await db.delete('languages', where: 'id = ?', whereArgs: [id]);
  }
}
