import 'package:sqflite/sqflite.dart';
import '../db/database_helper.dart';
import '../models/profile_model.dart';

class ProfileDB {
  final dbHelper = DatabaseHelper.instance;

  Future<int> updateProfile(ProfileModel profile) async {
    final db = await dbHelper.database;
    // We use id = 1 because there is only ever one profile
    return await db.insert(
      'profile',
      profile.toMap()..['id'] = 1,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<ProfileModel?> getProfile() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'profile',
      where: 'id = 1',
    );
    if (maps.isNotEmpty) {
      return ProfileModel.fromMap(maps.first);
    }
    return null;
  }
}
