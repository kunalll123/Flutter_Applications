import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/data/models/activity_model.dart';
import 'package:my_portfolio/data/models/contact_model.dart';
import 'package:my_portfolio/data/models/education_model.dart';
import 'package:my_portfolio/data/models/experience_model.dart';
import 'package:my_portfolio/data/models/profile_model.dart';
import 'package:my_portfolio/data/models/project_model.dart';
import 'package:my_portfolio/data/models/skill_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ✅ FIX: Use a getter so it doesn't crash on initialization
  // Replace the string below with your ACTUAL UID from Firebase Console
  String get uid =>
      FirebaseAuth.instance.currentUser?.uid ??
      "1zN6KWuqXKbzZYWJ9jCxjlPpAf-IAXrhI";

  Future<void> saveProfile(ProfileModel profile) async {
    // Only allow saving if the admin is actually logged in
    if (FirebaseAuth.instance.currentUser == null) return;
    await _db
        .collection('users')
        .doc(uid)
        .set(profile.toMap(), SetOptions(merge: true));
  }

  Future<ProfileModel?> getProfile() async {
    var doc = await _db.collection('users').doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return ProfileModel.fromMap(doc.data()!);
    }
    return null;
  }

  Future<void> addExperience(ExperienceModel exp) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('experience')
        .doc(exp.id.toString())
        .set(exp.toMap());
  }

  Future<void> addEducation(EducationModel edu) async {
    // ✅ Added try-catch for safety
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('education')
          .doc(edu.id.toString())
          .set(edu.toMap());
    } catch (e) {
      debugPrint("Firebase Education Error: $e");
    }
  }

  Future<void> addProject(ProjectModel project) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('projects')
        .doc(project.id.toString())
        .set(project.toMap());
  }

  Future<void> deleteDocument(String collectionName, String docId) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection(collectionName)
          .doc(docId)
          .delete();
    } catch (e) {
      debugPrint("Error deleting from Firestore: $e");
    }
  }

  Future<void> addSkill(SkillModel skill) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('skills')
        .doc(skill.id.toString())
        .set(skill.toMap());
  }

  Future<void> addActivity(ActivityModel activity) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('activities')
        .add(activity.toMap());
  }

  Future<List<ActivityModel>> getActivities() async {
    var snapshot =
        await _db
            .collection('users')
            .doc(uid)
            .collection('activities')
            .orderBy('date', descending: true)
            .get();
    return snapshot.docs
        .map((doc) => ActivityModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> deleteActivity(String docId) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('activities')
        .doc(docId)
        .delete();
  }

  Future<void> sendContactMessage(ContactMessage msg) async {
    try {
      await _db.collection('contact_messages').add(msg.toMap());
    } catch (e) {
      debugPrint("Firestore Error: $e");
      rethrow;
    }
  }
}
