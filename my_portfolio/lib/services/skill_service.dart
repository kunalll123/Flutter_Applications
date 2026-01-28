import 'package:flutter/foundation.dart';
import 'package:my_portfolio/data/data_source/skill_db.dart';
import 'package:my_portfolio/data/models/skill_model.dart';

class SkillService {
  final SkillDB _mobileDb = SkillDB();

  // Mock data for Web
  final List<SkillModel> _webSkills = [
    SkillModel(name: "Flutter", category: "Mobile Dev", percentage: 90),
    SkillModel(name: "Java", category: "Backend", percentage: 85),
    SkillModel(name: "Spring Boot", category: "Backend", percentage: 80),
  ];

  Future<List<SkillModel>> fetchSkills() async {
    if (kIsWeb) {
      // Return mock data for web users
      return _webSkills;
    } else {
      // Return real SQLite data for mobile users
      return await _mobileDb.getSkills();
    }
  }

  Future<void> saveSkill(SkillModel skill) async {
    if (kIsWeb) {
      _webSkills.add(skill);
    } else {
      await _mobileDb.insertSkill(skill);
    }
  }
}
