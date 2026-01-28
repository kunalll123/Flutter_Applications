import 'package:sqflite/sqflite.dart';
import '../db/database_helper.dart';
import '../models/award_model.dart';

class AwardDB {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertAward(AwardModel award) async {
    final db = await dbHelper.database;
    return await db.insert('awards', award.toMap());
  }

  Future<List<AwardModel>> getAwards() async {
    final db = await dbHelper.database;
    final maps = await db.query('awards');
    return maps.map((e) => AwardModel.fromMap(e)).toList();
  }

  Future<int> deleteAward(int id) async {
    final db = await dbHelper.database;
    return await db.delete('awards', where: 'id = ?', whereArgs: [id]);
  }
}
