import 'package:flutter/material.dart';
import 'package:my_portfolio/data/data_source/experience_db.dart';
import 'package:my_portfolio/data/models/experience_model.dart';
import '../utils/responsive.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({Key? key}) : super(key: key);

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  final ExperienceDB _experienceDB = ExperienceDB();
  List<ExperienceModel> _experiences = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadExperienceData();
  }

  Future<void> _loadExperienceData() async {
    final data = await _experienceDB.getExperiences();
    if (mounted) {
      setState(() {
        _experiences = data;
        _isLoading = false;
      });
    }
  }

  // Method to show Add Dialog
  void _showAddExperienceDialog() {
    final roleController = TextEditingController();
    final companyController = TextEditingController();
    final durationController = TextEditingController();
    final periodController = TextEditingController();
    final respController = TextEditingController(); // Comma separated

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF1E1E2E),
            title: const Text(
              "Add Experience",
              style: TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSimpleTextField(
                    roleController,
                    "Role (e.g. Flutter Dev)",
                  ),
                  _buildSimpleTextField(companyController, "Company"),
                  _buildSimpleTextField(
                    durationController,
                    "Dates (e.g. Aug 24 - Oct 24)",
                  ),
                  _buildSimpleTextField(
                    periodController,
                    "Period (e.g. 3 Months)",
                  ),
                  _buildSimpleTextField(
                    respController,
                    "Responsibilities (split by comma)",
                    maxLines: 3,
                  ),
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
                  final newExp = ExperienceModel(
                    role: roleController.text,
                    company: companyController.text,
                    duration: durationController.text,
                    period: periodController.text,
                    responsibilities:
                        respController.text
                            .split(',')
                            .map((e) => e.trim())
                            .toList(),
                  );
                  await _experienceDB.insertExperience(newExp);
                  _loadExperienceData();
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }

  Widget _buildSimpleTextField(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38),
          filled: true,
          fillColor: Colors.white10,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Experience',
          style: TextStyle(fontSize: Responsive.fontSize(context, 20)),
        ),
        backgroundColor: const Color(0xFF1E1E2E),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2196F3),
        onPressed: _showAddExperienceDialog,
        child: const Icon(Icons.add),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A0E21), Color(0xFF1E1E2E)],
          ),
        ),
        child:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _experiences.isEmpty
                ? const Center(
                  child: Text(
                    "No experience added yet",
                    style: TextStyle(color: Colors.white54),
                  ),
                )
                : ListView.builder(
                  padding: EdgeInsets.all(Responsive.padding(context)),
                  itemCount: _experiences.length,
                  itemBuilder: (context, index) {
                    final exp = _experiences[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: _buildExperienceCard(
                        context,
                        exp.role,
                        exp.company,
                        exp.duration,
                        exp.period,
                        exp.responsibilities,
                        onDelete: () async {
                          await _experienceDB.deleteExperience(exp.id!);
                          _loadExperienceData();
                        },
                      ),
                    );
                  },
                ),
      ),
    );
  }

  Widget _buildExperienceCard(
    BuildContext context,
    String role,
    String company,
    String duration,
    String period,
    List<String> responsibilities, {
    VoidCallback? onDelete,
  }) {
    return Container(
      padding: EdgeInsets.all(Responsive.padding(context)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.08),
            Colors.white.withOpacity(0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(Responsive.isMobile(context) ? 12 : 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.work,
                  color: const Color(0xFF2196F3),
                  size: Responsive.iconSize(context, 30),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Responsive.fontSize(context, 18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      company,
                      style: TextStyle(
                        color: const Color(0xFF64B5F6),
                        fontSize: Responsive.fontSize(context, 15),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.white54, size: 14),
              const SizedBox(width: 8),
              Text(
                duration,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: Responsive.fontSize(context, 13),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  period,
                  style: const TextStyle(
                    color: Color(0xFF64B5F6),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Responsibilities:',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...responsibilities.map(
            (r) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•  ', style: TextStyle(color: Color(0xFF2196F3))),
                  Expanded(
                    child: Text(
                      r,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
