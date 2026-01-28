import 'package:flutter/material.dart';
import 'package:my_portfolio/data/data_source/education_db.dart';
import 'package:my_portfolio/data/models/education_model.dart';
import 'package:my_portfolio/services/firestore_service.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  final EducationDB _educationDB = EducationDB();
  List<EducationModel> _educations = [];

  @override
  void initState() {
    super.initState();
    _loadEducation();
  }

  Future<void> _loadEducation() async {
    final data = await _educationDB.getEducations();
    setState(() => _educations = data);
  }

  void _showEduDialog({EducationModel? edu}) {
    final isEdit = edu != null;
    final degreeController = TextEditingController(text: edu?.degree);
    final instController = TextEditingController(text: edu?.institution);
    final levelController = TextEditingController(text: edu?.level);
    final yearsController = TextEditingController(text: edu?.years);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF1E1E2E),
            title: Text(
              isEdit ? "Edit Education" : "Add Education",
              style: const TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildField(degreeController, "Degree (e.g. M.Sc)"),
                  _buildField(instController, "Institution"),
                  _buildField(levelController, "Level (e.g. Masters)"),
                  _buildField(yearsController, "Years (e.g. 2023-2025)"),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  // 1. Create the Model from your controllers
                  final newEdu = EducationModel(
                    id: edu?.id,
                    degree: degreeController.text,
                    institution: instController.text,
                    level: levelController.text,
                    years: yearsController.text,
                  );

                  if (isEdit) {
                    // 2a. Update Local SQLite
                    await _educationDB.updateEducation(newEdu);
                    // 2b. Update Firebase Cloud
                    await FirestoreService().addEducation(newEdu);
                  } else {
                    // 3a. Insert to local and get the auto-increment ID
                    int localId = await _educationDB.insertEducation(newEdu);

                    // 3b. Create the model including the NEW ID for Firebase
                    final finalEdu = EducationModel(
                      id: localId,
                      degree: newEdu.degree,
                      institution: newEdu.institution,
                      level: newEdu.level,
                      years: newEdu.years,
                    );

                    // 3c. Sync to Firebase
                    await FirestoreService().addEducation(finalEdu);
                  }

                  // 4. Refresh the UI list
                  await _loadEducation();

                  // 5. Close the dialog
                  Navigator.pop(context);

                  _showSnackBar(
                    isEdit ? "Education Updated!" : "Education Saved to Cloud!",
                  );
                },
                child: Text(isEdit ? "Update" : "Save"),
              ),
            ],
          ),
    );
  }

  Widget _buildField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white60),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Education'),
        backgroundColor: const Color(0xFF1E1E2E),
        actions: [
          IconButton(
            onPressed: () => _showEduDialog(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A0E21), Color(0xFF1E1E2E)],
          ),
        ),
        child:
            _educations.isEmpty
                ? const Center(
                  child: Text(
                    "No Education Data",
                    style: TextStyle(color: Colors.white54),
                  ),
                )
                : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: _educations.length,
                  itemBuilder: (context, index) {
                    final item = _educations[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InkWell(
                        onLongPress: () => _showEduDialog(edu: item),
                        child: _buildEducationCard(item),
                      ),
                    );
                  },
                ),
      ),
    );
  }

  Widget _buildEducationCard(EducationModel edu) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.school, color: Colors.blue, size: 30),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edu.level,
                      style: const TextStyle(color: Colors.blue, fontSize: 12),
                    ),
                    Text(
                      edu.degree,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  await _educationDB.deleteEducation(edu.id!);
                  _loadEducation();
                },
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(edu.institution, style: const TextStyle(color: Colors.white70)),
          Text(
            edu.years,
            style: const TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
