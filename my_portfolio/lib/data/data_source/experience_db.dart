import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../db/database_helper.dart';
import '../models/experience_model.dart';

class ExperienceDB {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertExperience(ExperienceModel exp) async {
    if (kIsWeb) return 0;
    final db = await dbHelper.database;
    return await db.insert('experience', exp.toMap());
  }

  Future<List<ExperienceModel>> getExperiences() async {
    if (kIsWeb) return [];
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('experience');
    return maps.map((e) => ExperienceModel.fromMap(e)).toList();
  }

  Future<int> updateExperience(ExperienceModel exp) async {
    final db = await dbHelper.database;
    return await db.update(
      'experience',
      exp.toMap(),
      where: 'id = ?',
      whereArgs: [exp.id],
    );
  }

  Future<int> deleteExperience(int id) async {
    final db = await dbHelper.database;
    return await db.delete('experience', where: 'id = ?', whereArgs: [id]);
  }
}
