// import 'package:my_portfolio/data/models/project_model.dart';

// final projects = [
//   Project(
//     title: "Flex Play",
//     description: "Cricket turf booking app using Flutter & Firebase",
//     tech: "Flutter • Firebase",
//     github: "https://github.com/kunal/flex-play",
//   ),
// ];

import 'package:sqflite/sqflite.dart';
import '../db/database_helper.dart';
import '../models/project_model.dart';

class ProjectDB {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertProject(ProjectModel project) async {
    final db = await dbHelper.database;
    return await db.insert('projects', project.toMap());
  }

  Future<List<ProjectModel>> getProjects() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('projects');

    return maps.map((e) => ProjectModel.fromMap(e)).toList();
  }

  Future<int> deleteProject(int id) async {
    final db = await dbHelper.database;
    return await db.delete('projects', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateProject(ProjectModel updated) async {}
}
