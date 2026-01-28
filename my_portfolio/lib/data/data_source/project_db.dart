import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../db/database_helper.dart';
import '../models/project_model.dart';

class ProjectDB {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertProject(ProjectModel project) async {
    if (kIsWeb) return 0;
    final db = await dbHelper.database;
    return await db.insert(
      'projects',
      project.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ProjectModel>> getProjects() async {
    if (kIsWeb) return [];
    final db = await dbHelper.database;
    final maps = await db.query('projects');
    return maps.map((e) => ProjectModel.fromMap(e)).toList();
  }

  // ✅ The method that was causing the error
  Future<int> updateProject(ProjectModel project) async {
    if (kIsWeb) return 0;
    final db = await dbHelper.database;

    return await db.update(
      'projects',
      project.toMap(),
      where: 'id = ?',
      whereArgs: [project.id],
    );
  }

  Future<int> deleteProject(int id) async {
    if (kIsWeb) return 0;
    final db = await dbHelper.database;
    return await db.delete('projects', where: 'id = ?', whereArgs: [id]);
  }
}
