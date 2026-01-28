import 'package:my_portfolio/data/data_source/education_db.dart';

import '../data/data_source/profile_db.dart';
import '../data/data_source/project_db.dart';
import '../data/data_source/skill_db.dart';
import '../data/data_source/experience_db.dart';
import 'firestore_service.dart';

class MigrationService {
  final ProfileDB _profileDB = ProfileDB();
  final ProjectDB _projectDB = ProjectDB();
  final SkillDB _skillDB = SkillDB();
  final ExperienceDB _experienceDB = ExperienceDB();
  final EducationDB _educationDB = EducationDB(); //
  final FirestoreService _firestore = FirestoreService();

  Future<void> migrateAllData() async {
    try {
      // 1. Migrate Profile
      final profile = await _profileDB.getProfile();
      if (profile != null) {
        await _firestore.saveProfile(profile);
      }

      // 2. Migrate Projects
      final projects = await _projectDB.getProjects();
      for (var project in projects) {
        await _firestore.addProject(project);
      }

      // 3. Migrate Skills
      final skills =
          await _skillDB.getSkills(); // Ensure you have this method in SkillDB
      for (var skill in skills) {
        await _firestore.addSkill(skill);
      }

      // 4. Migrate Experience
      final experiences = await _experienceDB.getExperiences();
      for (var exp in experiences) {
        await _firestore.addExperience(
          exp,
        ); // Add this method to FirestoreService
      }

      final educations = await _educationDB.getEducations();
      for (var edu in educations) {
        await _firestore.addEducation(edu);
      }
      print("Migration Successful!");
    } catch (e) {
      print("Migration Failed: $e");
    }
  }
}
