import 'package:sqflite/sqflite.dart';
import '../db/database_helper.dart';
import '../models/certification_model.dart';

class CertificationDB {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertCertification(CertificationModel cert) async {
    final db = await dbHelper.database;
    return await db.insert('certifications', cert.toMap());
  }

  Future<List<CertificationModel>> getCertifications() async {
    final db = await dbHelper.database;
    final maps = await db.query('certifications');
    return maps.map((e) => CertificationModel.fromMap(e)).toList();
  }

  Future<int> updateCertification(CertificationModel cert) async {
    final db = await dbHelper.database;
    return await db.update(
      'certifications',
      cert.toMap(),
      where: 'id = ?',
      whereArgs: [cert.id],
    );
  }

  Future<int> deleteCertification(int id) async {
    final db = await dbHelper.database;
    return await db.delete('certifications', where: 'id = ?', whereArgs: [id]);
  }
}
