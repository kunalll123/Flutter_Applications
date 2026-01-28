import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../db/database_helper.dart';
import '../models/skill_model.dart';

class SkillDB {
  final dbHelper = DatabaseHelper.instance;

  // --- EXISTING METHODS ---
  Future<int> insertSkill(SkillModel skill) async {
    if (kIsWeb) return 0;
    final db = await dbHelper.database;
    return await db.insert(
      'skills',
      skill.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SkillModel>> getSkills() async {
    if (kIsWeb) return [];
    final db = await dbHelper.database;
    final maps = await db.query('skills');
    return maps.map((e) => SkillModel.fromMap(e)).toList();
  }

  // --- THE MISSING METHOD (ADD THIS) ---
  Future<int> updateSkill(SkillModel skill) async {
    if (kIsWeb) return 0;
    final db = await dbHelper.database;

    // We use the 'id' to find the specific skill to update
    return await db.update(
      'skills',
      skill.toMap(),
      where: 'id = ?',
      whereArgs: [skill.id],
    );
  }

  Future<int> deleteSkill(int id) async {
    if (kIsWeb) return 0;
    final db = await dbHelper.database;
    return await db.delete('skills', where: 'id = ?', whereArgs: [id]);
  }
}
