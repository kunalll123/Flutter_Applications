// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../data/models/skill_model.dart';
// import '../data/models/project_model.dart';

// class FirestoreSyncService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final String uid = FirebaseAuth.instance.currentUser!.uid;

//   // Generic function to save any collection
//   Future<void> syncCollection(
//     String collectionName,
//     List<dynamic> models,
//   ) async {
//     final batch = _db.batch();
//     final collectionRef = _db
//         .collection('users')
//         .doc(uid)
//         .collection(collectionName);

//     // Delete old cloud data to avoid duplicates before syncing fresh local data
//     final oldDocs = await collectionRef.get();
//     for (var doc in oldDocs.docs) {
//       batch.delete(doc.reference);
//     }

//     // Add current local data to batch
//     for (var model in models) {
//       final newDoc = collectionRef.doc();
//       batch.set(newDoc, model.toMap());
//     }

//     await batch.commit();
//   }
// }
