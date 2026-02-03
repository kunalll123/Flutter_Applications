import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
// Adjust this path to where you created storage_service.dart
import 'package:wroom_application/features/auth/pages/storage_service.dart';

class FirebaseStorageHelper {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  // 1. Pick an image from Gallery
  Future<File?> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70, // Compresses image to save storage
    );
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  // 2. Upload file and return the Download URL
  Future<String?> uploadFile(File file, String folder) async {
    try {
      // Create a unique filename
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference ref = _storage.ref().child(folder).child(fileName);

      // Start upload
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;

      // Return the public URL
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print("Error uploading to Firebase: $e");
      return null;
    }
  }
}
