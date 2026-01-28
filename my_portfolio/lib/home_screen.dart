import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_portfolio/data/models/activity_model.dart';
import 'package:my_portfolio/data/data_source/award_db.dart';
import 'package:my_portfolio/data/data_source/certification_db.dart';
import 'package:my_portfolio/data/data_source/education_db.dart';
import 'package:my_portfolio/data/data_source/experience_db.dart';
import 'package:my_portfolio/data/data_source/language_db.dart';
import 'package:my_portfolio/data/data_source/portfolio_db.dart';
import 'package:my_portfolio/data/data_source/profile_db.dart';
import 'package:my_portfolio/data/models/award_model.dart';
import 'package:my_portfolio/data/models/certification_model.dart';
import 'package:my_portfolio/data/models/education_model.dart';
import 'package:my_portfolio/data/models/experience_model.dart';
import 'package:my_portfolio/data/models/language_model.dart';
import 'package:my_portfolio/data/models/profile_model.dart';
import 'package:my_portfolio/data/models/project_model.dart';
import 'package:my_portfolio/education_screen.dart';
import 'package:my_portfolio/experience_screen.dart';
import 'package:my_portfolio/main.dart';
import 'package:my_portfolio/services/firestore_service.dart';
import 'package:my_portfolio/services/migration_service.dart';
import 'package:my_portfolio/services/skill_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_portfolio/data/data_source/skill_db.dart';
import 'package:my_portfolio/data/models/skill_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Load both Skills and Projects from DB
    _loadAllData();

    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  late AnimationController _floatingController;

  List<ActivityModel> _dbActivities =
      []; // ✅ Add this line to fix the 'Undefined name' error

  // ✅ Add these new visibility variables
  bool _showLanguages = false;
  bool _showVolunteer = false;
  bool _showAwards = false;

  File? _mobileCoverImage;
  Uint8List? _webCoverImage;
  File? _mobileImage;
  Uint8List? _webImage;
  String? _savedImagePath; // To keep track of the path

  String _name = "Kunal Sonawane";
  String _headline = "Flutter Developer | Java | Spring Boot Developer";
  String _location = "Pune, Maharashtra, India";
  String _about =
      "Passionate developer with hands-on experience in Flutter, Java, Spring Boot, and MySQL. I love building real-world applications with clean UI and scalable backend architecture. Always eager to learn new technologies and contribute to innovative projects.";

  String _email = "";
  String _phone = "";
  String _linkedIn = "";
  bool _isOpenToWork = true;

  final List<Map<String, String>> _experiences = [
    {
      "title": "Flutter Intern",
      "company": "Incubators",
      "duration": "Aug 2024 - Oct 2024 • 3 mos",
      "location": "Pune, Maharashtra, India",
      "description":
          "Worked on real Flutter applications, developing cross-platform mobile solutions and collaborating with the development team on various projects.",
    },
  ];

  final List<Map<String, String>> _education = [
    {
      "school": "Fergusson College, Pune",
      "degree": "Master of Computer Applications - MCA",
      "years": "2023 - 2025",
    },
    {
      "school": "KTHM College, Nashik",
      "degree": "Bachelor of Science - B.Sc Computer Science",
      "years": "2020 - 2023",
    },
  ];

  final ProfileDB _profileDB = ProfileDB();

  final SkillDB _skillDB = SkillDB();
  List<SkillModel> _skills = [];
  final SkillService _skillService = SkillService();

  // Add these to your other variables (near _skills)
  final ProjectDB _projectDB = ProjectDB();
  List<ProjectModel> _dbProjects =
      []; // This solves the 'Undefined name _dbProjects'

  final ExperienceDB _experienceDB = ExperienceDB();
  List<ExperienceModel> _dbExperiences = [];

  final EducationDB _educationDB = EducationDB();
  List<EducationModel> _dbEducation = [];

  final CertificationDB _certDB = CertificationDB();
  List<CertificationModel> _dbCertifications = [];

  List<LanguageModel> _dbLanguages = [];
  List<AwardModel> _dbAwards = [];

  final LanguageDB _languageDB = LanguageDB();
  final AwardDB _awardDB = AwardDB();

  Future<void> _loadSkills() async {
    final data = await _skillService.fetchSkills(); // Fetch data first
    if (mounted) {
      setState(() {
        _skills = data; // Sync UI
      });
    }
  }

  Future<void> _loadAllData() async {
    final firestore = FirestoreService();

    try {
      // 1. Try to fetch Profile from Firebase
      final cloudProfile = await firestore.getProfile();
      if (cloudProfile != null) {
        // ✅ If found in cloud, sync it to local SQFlite
        await _profileDB.updateProfile(cloudProfile);
      }

      // 2. Fetch all data for the UI (this now contains the latest synced data)
      final profileData = await _profileDB.getProfile();
      final skillData = await _skillService.fetchSkills();
      final projectData = await _projectDB.getProjects();
      final expData = await _experienceDB.getExperiences();
      final eduData = await _educationDB.getEducations();
      final certData = await _certDB.getCertifications();
      final langData = await _languageDB.getLanguages();
      final awardData = await _awardDB.getAwards();
      final activityData = await firestore.getActivities();

      if (mounted) {
        setState(() {
          _skills = skillData;
          _dbProjects = projectData;
          _dbExperiences = expData;
          _dbEducation = eduData;
          _dbCertifications = certData;
          _dbLanguages = langData;
          _dbAwards = awardData;
          _dbActivities = activityData;

          if (profileData != null) {
            _name = profileData.name;
            _headline = profileData.headline;
            _location = profileData.location;
            _about = profileData.about;
            _isOpenToWork = profileData.isOpenToWork == 1;
            _showLanguages = profileData.showLanguages == 1;
            _showVolunteer = profileData.showVolunteer == 1;
            _showAwards = profileData.showAwards == 1;

            if (profileData.profileImagePath != null) {
              _savedImagePath = profileData.profileImagePath;
              // Use network image if it's a URL, otherwise use File
              if (_savedImagePath!.startsWith('http')) {
                _mobileImage = null; // UI logic will handle NetworkImage
              } else {
                _mobileImage = File(_savedImagePath!);
              }
            }
          }
        });
      }
    } catch (e) {
      debugPrint("Sync Error: $e");
      // If Firebase fails (no internet), it will just show whatever is in SQFlite
    }
  }

  final List<Map<String, String>> _projects = [
    {
      "title": "Flex Play – Turf Booking App",
      "description":
          "A comprehensive turf booking application built with Flutter and Firebase, featuring real-time availability, secure payments, and user-friendly interface.",
      "tech": "Flutter • Firebase • REST APIs",
      "url": "https://github.com/",
    },
    {
      "title": "Music Player App",
      "description":
          "Feature-rich music player application with playlist management, audio visualization, and cloud integration using Flutter and Firebase.",
      "tech": "Flutter • Firebase • Audio APIs",
      "url": "https://github.com/",
    },
  ];

  final List<Map<String, String>> _certifications = [
    {
      "title": "Flutter Certification",
      "issuer": "Incubators",
      "date": "Issued Oct 2024",
    },
    {
      "title": "Super X Program",
      "issuer": "Professional Development",
      "date": "Issued 2024",
    },
  ];

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();

    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await prefs.setBool('isDarkMode', false); // ✅ Save choice
    } else {
      themeNotifier.value = ThemeMode.dark;
      await prefs.setBool('isDarkMode', true); // ✅ Save choice
    }
  }

  Future<void> _pickCoverImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    if (kIsWeb) {
      final bytes = await image.readAsBytes();
      setState(() => _webCoverImage = bytes);
    } else {
      setState(() => _mobileCoverImage = File(image.path));
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    // We are using the local path from the device instead of a Cloud URL
    String localPath = image.path;

    try {
      // 1. Prepare the model with the LOCAL PATH
      final updatedProfile = ProfileModel(
        name: _name,
        headline: _headline,
        location: _location,
        about: _about,
        profileImagePath: localPath, // ✅ Store local file path
        email: _email,
        phone: _phone,
        linkedIn: _linkedIn,
        isOpenToWork: _isOpenToWork ? 1 : 0,
        showLanguages: _showLanguages ? 1 : 0,
        showVolunteer: _showVolunteer ? 1 : 0,
        showAwards: _showAwards ? 1 : 0,
      );

      // 2. Update Local SQLite (So it persists on this device)
      await _profileDB.updateProfile(updatedProfile);

      // 3. Update Firestore (Syncs the path string, but not the actual file)
      await FirestoreService().saveProfile(updatedProfile);

      // 4. Update UI state
      setState(() {
        _mobileImage = File(localPath);
        _savedImagePath = localPath;
      });

      _showSnackBar("Profile image updated locally!");
    } catch (e) {
      _showSnackBar("Error saving image: $e");
    }
  }

  // Recommended Section Widget
  Widget _recommendedSection() {
    if (_showAwards && _showLanguages && _showVolunteer)
      return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recommended for you",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const Text(
            "Complete your profile to stand out to recruiters.",
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: _showAddSectionDialog,
            child: const Text(
              "Add dynamic sections +",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _projectItem(
    String title,
    String description,
    String tech,
    String url, {
    VoidCallback? onEdit,
    VoidCallback? onDelete,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(Icons.code, color: Colors.black54),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        PopupMenuButton(
                          icon: const Icon(Icons.more_vert, size: 20),
                          itemBuilder:
                              (context) => [
                                PopupMenuItem(
                                  onTap: onEdit,
                                  child: const Text("Edit"),
                                ),
                                PopupMenuItem(
                                  onTap: onDelete,
                                  child: const Text("Delete"),
                                ),
                              ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tech,
                      style: TextStyle(
                        color: Colors.blue.shade300,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () => launchUrl(Uri.parse(url)),
                      child: const Text(
                        "View Code →",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white10, height: 32),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, child) {
        final isDark = mode == ThemeMode.dark;

        return Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: Container(
              key: ValueKey(isDark),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors:
                      isDark
                          ? [const Color(0xFF0F172A), const Color(0xFF1E293B)]
                          : [const Color(0xFFF1F5F9), const Color(0xFFE2E8F0)],
                ),
              ),
              child: Stack(
                children: [
                  /// 🔹 Animated Background Particles
                  ...List.generate(15, (index) {
                    return Positioned(
                      left: (index * 120) % size.width,
                      top: (index * 90) % size.height,
                      child: Container(
                            width: 3,
                            height: 3,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  isDark
                                      ? Colors.blueAccent.withOpacity(0.3)
                                      : Colors.blue.withOpacity(0.1),
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 800.ms)
                          .shimmer(delay: 1000.ms),
                    );
                  }),

                  SafeArea(
                    child: Stack(
                      children: [
                        ListView(
                          padding: const EdgeInsets.only(top: 80, bottom: 100),
                          children: [
                            _profileCard(context, isMobile),
                            const SizedBox(height: 10),
                            _recommendedSection(),
                            _aboutCard(),
                            _activityCard(),
                            _experienceCard(),
                            _educationCard(),
                            _skillsCard(),
                            _projectsCard(),
                            _certificationsCard(),

                            // ✅ These must be inside the ListView to scroll
                            if (_showLanguages) _buildLanguagesCard(),
                            if (_showAwards) _buildAwardsCard(),
                            // if (_showVolunteer)
                            //   _buildGenericSection(
                            //     "Volunteer",
                            //     Icons.volunteer_activism,
                            //     "Community help...",
                            //   ),
                          ],
                        ),

                        /// 🔹 UNIFIED CREATIVE TOP BAR (Only one set of buttons)
                        Positioned(
                          top: 15,
                          right: 15,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isDark
                                          ? Colors.white.withOpacity(0.05)
                                          : const Color.fromARGB(
                                            255,
                                            88,
                                            64,
                                            64,
                                          ).withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color:
                                        isDark
                                            ? Colors.white10
                                            : Colors.black12,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: toggleTheme,
                                      child: Icon(
                                        isDark
                                            ? Icons.wb_sunny_rounded
                                            : Icons.nightlight_round,
                                        color:
                                            isDark
                                                ? Colors.amber
                                                : Colors.indigo,
                                        size: 22,
                                      ),
                                    ),
                                    // const SizedBox(width: 15),
                                    // GestureDetector(
                                    //   onTap:
                                    //       () async =>
                                    //           await FirebaseAuth.instance
                                    //               .signOut(),
                                    //   child: const Icon(
                                    //     Icons.power_settings_new,
                                    //     color: Colors.redAccent,
                                    //     size: 22,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Clean Floating Action Button
          // floatingActionButton: FloatingActionButton(
          //   onPressed: _showMoreOptions,
          //   backgroundColor:
          //       isDark ? const Color(0xFF6366F1) : const Color(0xFF475569),
          //   child: const Icon(Icons.bolt, color: Colors.white),
          // ).animate().scale(delay: 400.ms),
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }

  Widget _buildAwardsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Honors & Awards",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 20),
                onPressed: _addAwardDialog,
              ),
            ],
          ),
          // Inside _buildAwardsCard mapping:
          ..._dbAwards.map(
            (award) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.emoji_events, color: Colors.amber),
              title: Text(
                award.title,
                style: GoogleFonts.poppins(
                  color:
                      themeNotifier.value == ThemeMode.dark
                          ? Colors.white70
                          : const Color(
                            0xFF475569,
                          ), // 👈 Slate Blue-Grey for Light Mode
                  fontSize: 14,
                ),
              ),
              subtitle: Text("${award.issuer} • ${award.date}"),
              trailing: IconButton(
                // ✅ Add this to allow deleting entries
                icon: const Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: Colors.redAccent,
                ),
                onPressed: () async {
                  await _awardDB.deleteAward(award.id!);
                  await _loadAllData();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ ADD THIS: The real Languages Section
  Widget _buildLanguagesCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Languages",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 20),
                onPressed: _addLanguageDialog,
              ),
            ],
          ),
          if (_dbLanguages.isEmpty)
            const Text(
              "No languages added.",
              style: TextStyle(color: Colors.white54, fontSize: 13),
            ),
          ..._dbLanguages.map(
            (lang) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.language, color: Colors.blue),
              title: Text(
                lang.name,
                style: GoogleFonts.poppins(
                  color:
                      themeNotifier.value == ThemeMode.dark
                          ? Colors.white70
                          : const Color(
                            0xFF475569,
                          ), // 👈 Slate Blue-Grey for Light Mode
                  fontSize: 14,
                ),
              ),
              subtitle: Text(
                lang.proficiency,
                style: GoogleFonts.poppins(
                  color:
                      themeNotifier.value == ThemeMode.dark
                          ? Colors.white70
                          : const Color(
                            0xFF475569,
                          ), // 👈 Slate Blue-Grey for Light Mode
                  fontSize: 14,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: Colors.redAccent,
                ),
                onPressed: () async {
                  await _languageDB.deleteLanguage(lang.id!);
                  await _loadAllData();
                },
              ),
            ),
          ),
          const Divider(color: Colors.white10),
        ],
      ),
    );
  }

  // ✅ ADD THIS: Generic placeholder for Volunteer
  Widget _buildGenericSection(String title, IconData icon, String hint) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue, size: 24),
              const SizedBox(width: 10),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            hint,
            style: const TextStyle(color: Colors.white54, fontSize: 14),
          ),
          const Divider(color: Colors.white10),
        ],
      ),
    );
  }

  Widget glassCard({required Widget child}) {
    bool isDark = themeNotifier.value == ThemeMode.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color:
            isDark
                ? const Color(0xFF1E1E2B).withOpacity(0.8)
                : Colors.white.withOpacity(0.9), // ✅ Translucent White
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color:
              isDark
                  ? Colors.white.withOpacity(0.08)
                  : Colors.blue.withOpacity(0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black45 : Colors.blueGrey.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: child,
        ),
      ),
    );
  }

  // ================= PROFILE CARD =================
  // ================= PROFILE CARD =================
  Widget _profileCard(BuildContext context, bool isMobile) {
    return glassCard(
      child: Column(
        children: [
          // ✅ 1. LOGOUT BUTTON AT THE VERY TOP
          // Align(
          //   alignment: Alignment.topRight,
          //   child: IconButton(
          //     icon: const Icon(Icons.logout, color: Colors.redAccent),
          //     onPressed: () async {
          //       await FirebaseAuth.instance.signOut();
          //       _showSnackBar("Logged out successfully");
          //     },
          //   ),
          // ),

          // ✅ 2. PROFILE IMAGE (Moved here to be above the name)
          Stack(
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3B82F6).withOpacity(0.6),
                        blurRadius: 30,
                        spreadRadius: 6,
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color.fromARGB(255, 4, 5, 5),
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: isMobile ? 48 : 62,
                      backgroundColor: const Color.fromARGB(255, 240, 241, 244),
                      backgroundImage: _getProfileImage(),
                      child:
                          (_mobileImage == null && _webImage == null)
                              ? Icon(
                                Icons.person,
                                size: isMobile ? 50 : 64,
                                color: Colors.white.withOpacity(0.5),
                              )
                              : null,
                    ),
                  ),
                ),
              ).animate().fade().scale(),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(
              left: isMobile ? 20 : 24,
              right: isMobile ? 20 : 24,
              top: 20, // 🔹 Reduced top padding since image is already here
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // 🔹 Centered for better look
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // 🔹 Centered Name
                  children: [
                    Flexible(
                      child: Text(
                        _name,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 24 : 32,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Color.fromARGB(255, 162, 151, 151),
                      ),
                      onPressed: () => _editProfileInfo(),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  _headline,
                  textAlign: TextAlign.center, // 🔹 Centered Headline
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 16 : 18,
                    color: const Color.fromARGB(221, 211, 209, 209),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                // Rest of your connection info...
                // Find this section inside _profileCard and replace it:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        _location,
                        style: GoogleFonts.poppins(
                          color:
                              themeNotifier.value == ThemeMode.dark
                                  ? Colors.white70
                                  : const Color(0xFF475569),
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () => _showContactInfo(),
                      child: const Text(
                        "• Contact info",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // ... (Your Open to Work / Add Section buttons)
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= ABOUT CARD =================
  Widget _aboutCard() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "About",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () => _editAbout(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              _about,
              style: GoogleFonts.poppins(
                color:
                    themeNotifier.value == ThemeMode.dark
                        ? Colors.white70
                        : const Color(
                          0xFF475569,
                        ), // 👈 Slate Blue-Grey for Light Mode
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= ACTIVITY CARD =================
  Widget _activityCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Activity",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.add_comment_outlined,
                  size: 22,
                  //color: Color.fromARGB(255, 247, 249, 250),
                ),
                onPressed: _showAddActivityDialog, // We will create this next
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Dynamic List of Activities
          if (_dbActivities
              .isEmpty) // You'll need to define this list in your State
            Text(
              "You haven't shared any updates yet.",
              style: GoogleFonts.poppins(
                color:
                    themeNotifier.value == ThemeMode.dark
                        ? Colors.white70
                        : const Color(
                          0xFF475569,
                        ), // 👈 Slate Blue-Grey for Light Mode
                fontSize: 14,
              ),
            )
          else
            ..._dbActivities.map(
              (activity) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.content,
                      style: GoogleFonts.poppins(
                        color:
                            themeNotifier.value == ThemeMode.dark
                                ? Colors.white70
                                : const Color(
                                  0xFF475569,
                                ), // 👈 Slate Blue-Grey for Light Mode
                        fontSize: 14,
                      ),
                    ),

                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: Colors.redAccent,
                      ),
                      onPressed: () async {
                        if (activity.id != null) {
                          // ✅ Call the service using the Firebase ID
                          await FirestoreService().deleteActivity(activity.id!);

                          // ✅ Refresh the list immediately
                          await _loadAllData();

                          _showSnackBar("Post deleted");
                        }
                      },
                    ),

                    Text(
                      activity.date,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                    ),
                    const Divider(color: Colors.white10),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ================= EXPERIENCE CARD =================
  // ================= EXPERIENCE CARD (DYNAMIC) =================
  Widget _experienceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ✅ Wrap the title or an icon to trigger navigation
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExperienceScreen(),
                    ),
                  ).then(
                    (_) => _loadAllData(),
                  ); // ✅ This triggers when you press back
                },
                child: Row(
                  children: [
                    Text(
                      "Experience",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.white54,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 24),
                onPressed: () => _addExperienceDialog(),
              ),
            ],
          ),

          // ... rest of your experience mapping code
          const SizedBox(height: 16),

          // Show message if no data exists in SQFlite
          if (_dbExperiences.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "No experience added yet.",
                style: GoogleFonts.poppins(
                  color:
                      themeNotifier.value == ThemeMode.dark
                          ? Colors.white70
                          : const Color(
                            0xFF475569,
                          ), // 👈 Slate Blue-Grey for Light Mode
                  fontSize: 14,
                ),
              ),
            ),

          // ✅ Map through database results instead of hardcoded list
          ..._dbExperiences.map(
            (exp) => _experienceItem(
              exp.role,
              exp.company,
              exp.duration,
              exp.period,
              exp.responsibilities.join(
                ', ',
              ), // Displaying first few for preview
              onEdit:
                  () => _editExperienceDetails(
                    exp,
                  ), // You can add an edit dialog here
              onDelete: () async {
                // 1. Delete from local SQLite
                await _experienceDB.deleteExperience(exp.id!);

                // 2. Delete from Firebase Firestore - ADDED THIS
                await FirestoreService().deleteDocument(
                  'experience',
                  exp.id.toString(),
                );

                // 3. Refresh the UI
                await _loadAllData();
                _showSnackBar("Experience deleted from cloud and local.");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _experienceItem(
    String role,
    String company,
    String duration,
    String location,
    String description, {
    VoidCallback? onEdit,
    VoidCallback? onDelete,
  }) {
    // ✅ Check theme mode
    final bool isDark = themeNotifier.value == ThemeMode.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.business,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        role,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          // ✅ Dynamic Color
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                    PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        size: 20,
                        color: isDark ? Colors.white54 : Colors.black54,
                      ),
                      itemBuilder:
                          (context) => [
                            PopupMenuItem(
                              onTap: onEdit,
                              child: const Text("Edit"),
                            ),
                            PopupMenuItem(
                              onTap: onDelete,
                              child: const Text("Delete"),
                            ),
                          ],
                    ),
                  ],
                ),
                Text(
                  company,
                  style: TextStyle(
                    color: isDark ? Colors.blue.shade300 : Colors.blue.shade700,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  duration,
                  style: TextStyle(
                    color: isDark ? Colors.white38 : Colors.black45,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    // ✅ Dynamic Description Color
                    color: isDark ? Colors.white70 : Colors.black54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= EDUCATION CARD =================
  // ✅ Updated Education Card Widget for Home Screen
  Widget _educationCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Education",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 24),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EducationScreen(),
                    ),
                  ).then((_) => _loadAllData()); // ✅ Refresh when coming back
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_dbEducation.isEmpty)
            Text(
              "No education data added.",
              style: GoogleFonts.poppins(
                color:
                    themeNotifier.value == ThemeMode.dark
                        ? Colors.white70
                        : const Color(
                          0xFF475569,
                        ), // 👈 Slate Blue-Grey for Light Mode
                fontSize: 14,
              ),
            ),

          ..._dbEducation.map((edu) {
            final bool isDark = themeNotifier.value == ThemeMode.dark;
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  Icon(
                    Icons.school,
                    color: isDark ? Colors.blueAccent : Colors.blue.shade700,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          edu.degree,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            // ✅ Dynamic Title
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        Text(
                          edu.institution,
                          style: TextStyle(
                            // ✅ Dynamic Subtitle
                            color: isDark ? Colors.white70 : Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          edu.years,
                          style: TextStyle(
                            // ✅ Dynamic Date
                            color: isDark ? Colors.white38 : Colors.black38,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _educationItem(
    String school,
    String degree,
    String years, {
    VoidCallback? onEdit,
    VoidCallback? onDelete,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.school, color: Colors.grey),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        school,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    PopupMenuButton(
                      icon: Icon(Icons.more_vert, size: 20),
                      itemBuilder:
                          (context) => [
                            PopupMenuItem(
                              child: const Text("Edit"),
                              onTap: onEdit,
                            ),
                            PopupMenuItem(
                              child: const Text("Delete"),
                              onTap: onDelete,
                            ),
                          ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  degree,
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color.fromARGB(221, 240, 240, 240),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  years,
                  style: TextStyle(
                    fontSize: 13,
                    color: const Color.fromARGB(221, 240, 240, 240),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= SKILLS CARD =================
  Widget _skillsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Skills",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 24),
                onPressed: () => _addSkill(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Pass the index so we know which skill to delete
          ..._skills.asMap().entries.map((entry) {
            int index = entry.key;
            var skill = entry.value;
            return InkWell(
              onLongPress:
                  () => _showEditSkillDialog(skill), // ✅ Long press to edit
              child: _skillItem(
                skill.name,
                skill.category,
                onDelete: () => _deleteSkill(index),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _skillItem(String skill, String category, {VoidCallback? onDelete}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      skill,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, size: 18, color: Colors.grey.shade600),
                onPressed: onDelete,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: Colors.grey.shade300, height: 1),
        ],
      ),
    );
  }

  // ================= PROJECTS CARD =================
  Widget _projectsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Projects",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 24),
                onPressed: () => _addProject(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_dbProjects.isEmpty)
            Text(
              "No projects added yet.",
              style: GoogleFonts.poppins(
                color:
                    themeNotifier.value == ThemeMode.dark
                        ? Colors.white70
                        : const Color(
                          0xFF475569,
                        ), // 👈 Slate Blue-Grey for Light Mode
                fontSize: 14,
              ),
            ),
          ..._dbProjects.map(
            (project) => _projectItem(
              project.title,
              project.description,
              project.techStack,
              project.githubUrl,
              onEdit: () => _editProjectDetails(project),
              onDelete: () async {
                await _projectDB.deleteProject(project.id!);
                await _loadAllData();
              },
            ),
          ),
        ],
      ),
    );
  }

  // ================= CERTIFICATIONS CARD =================
  Widget _certificationsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Licenses & Certifications",
                style: GoogleFonts.poppins(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 24),
                onPressed: () => _addCertification(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_dbCertifications.isEmpty)
            Text(
              "No certifications added yet.",
              style: GoogleFonts.poppins(
                color:
                    themeNotifier.value == ThemeMode.dark
                        ? Colors.white70
                        : const Color(
                          0xFF475569,
                        ), // 👈 Slate Blue-Grey for Light Mode
                fontSize: 14,
              ),
            ),
          ..._dbCertifications.map(
            (cert) => _certificationItem(
              cert.title,
              cert.issuer,
              cert.date,
              onEdit:
                  () => _editCertDetails(
                    cert,
                  ), // Create this similar to editExperience
              onDelete: () async {
                await _certDB.deleteCertification(cert.id!);
                await _loadAllData();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _editCertDetails(CertificationModel cert) {
    final titleController = TextEditingController(text: cert.title);
    final issuerController = TextEditingController(text: cert.issuer);
    final dateController = TextEditingController(text: cert.date);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Edit Certification"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                TextField(
                  controller: issuerController,
                  decoration: const InputDecoration(labelText: "Issuer"),
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: "Date"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final updatedCert = CertificationModel(
                    id: cert.id, // ✅ Essential: Keep the ID so SQLite knows which row to update
                    title: titleController.text,
                    issuer: issuerController.text,
                    date: dateController.text,
                  );

                  await _certDB.updateCertification(updatedCert);
                  await _loadAllData(); // ✅ Refresh the UI list
                  Navigator.pop(context);
                  _showSnackBar("Certification updated!");
                },
                child: const Text("Update"),
              ),
            ],
          ),
    );
  }

  Widget _certificationItem(
    String title,
    String issuer,
    String date, {
    VoidCallback? onEdit,
    VoidCallback? onDelete,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.workspace_premium, color: Colors.grey),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    PopupMenuButton(
                      icon: Icon(Icons.more_vert, size: 20),
                      itemBuilder:
                          (context) => [
                            PopupMenuItem(
                              child: const Text("Edit"),
                              onTap: onEdit,
                            ),
                            PopupMenuItem(
                              child: const Text("Delete"),
                              onTap: onDelete,
                            ),
                          ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  issuer,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= EDIT DIALOGS =================
  void _editProfileInfo() {
    final nameController = TextEditingController(text: _name);
    final headlineController = TextEditingController(text: _headline);
    final locationController = TextEditingController(text: _location);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Edit Profile"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: headlineController,
                  decoration: const InputDecoration(labelText: "Headline"),
                ),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: "Location"),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                // Inside _editProfileInfo ElevatedButton onPressed:
                onPressed: () async {
                  final updatedProfile = ProfileModel(
                    name: nameController.text,
                    headline: headlineController.text,
                    location: locationController.text,
                    about: _about,
                    profileImagePath: _savedImagePath,
                  );

                  // ✅ 1. Save to local DB (Keep this for offline speed)
                  await _profileDB.updateProfile(updatedProfile);

                  // ✅ 2. Save to Firebase (Cloud Storage)
                  await FirestoreService().saveProfile(updatedProfile);

                  await _loadAllData();
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }

  void _addAwardDialog() {
    final titleController = TextEditingController();
    final issuerController = TextEditingController();
    final dateController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Add Honor/Award"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Award Title"),
                ),
                TextField(
                  controller: issuerController,
                  decoration: const InputDecoration(labelText: "Issuer"),
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: "Date (e.g. 2025)",
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _awardDB.insertAward(
                    AwardModel(
                      title: titleController.text,
                      issuer: issuerController.text,
                      date: dateController.text,
                    ),
                  );
                  await _loadAllData();
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }

  void _addLanguageDialog() {
    final nameController = TextEditingController();
    String proficiency = "Native";

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: const Text("Add Language"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "Language Name",
                        ),
                      ),
                      DropdownButton<String>(
                        value: proficiency,
                        isExpanded: true,
                        items:
                            [
                                  "Native",
                                  "Professional",
                                  "Elementary",
                                  "Limited Working",
                                ]
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            (val) => setDialogState(() => proficiency = val!),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await _languageDB.insertLanguage(
                          LanguageModel(
                            name: nameController.text,
                            proficiency: proficiency,
                          ),
                        );
                        await _loadAllData();
                        Navigator.pop(context);
                      },
                      child: const Text("Save"),
                    ),
                  ],
                ),
          ),
    );
  }

  void _editAbout() {
    final controller = TextEditingController(text: _about);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF1E1E2E), // Match your theme
            title: const Text(
              "Edit About",
              style: TextStyle(color: Colors.white),
            ),
            content: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
                hintText: "Tell us about yourself...",
                hintStyle: TextStyle(color: Colors.white54),
              ),
              maxLines: 6,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  // 1. Prepare the updated model with the new text from the controller
                  final updatedProfile = ProfileModel(
                    name: _name,
                    headline: _headline,
                    location: _location,
                    about: controller.text, // ✅ The new text
                    profileImagePath: _savedImagePath,
                    email: _email,
                    phone: _phone,
                    linkedIn: _linkedIn,
                    isOpenToWork: _isOpenToWork ? 1 : 0,
                    showLanguages: _showLanguages ? 1 : 0,
                    showVolunteer: _showVolunteer ? 1 : 0,
                    showAwards: _showAwards ? 1 : 0,
                  );

                  try {
                    // ✅ 2. Save to local SQFlite (for offline and speed)
                    await _profileDB.updateProfile(updatedProfile);

                    // ✅ 3. Sync to Firebase Firestore (for cloud backup)
                    await FirestoreService().saveProfile(updatedProfile);

                    // 4. Refresh the local state and UI
                    await _loadAllData();

                    if (mounted) {
                      Navigator.pop(context);
                      _showSnackBar("About section saved to cloud and local!");
                    }
                  } catch (e) {
                    _showSnackBar("Failed to save: $e");
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }

  void _addExperienceDialog() {
    final roleController = TextEditingController();
    final companyController = TextEditingController();
    final durationController = TextEditingController();
    final periodController = TextEditingController();
    final respController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Add Experience"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: roleController,
                    decoration: const InputDecoration(labelText: "Role"),
                  ),
                  TextField(
                    controller: companyController,
                    decoration: const InputDecoration(labelText: "Company"),
                  ),
                  TextField(
                    controller: durationController,
                    decoration: const InputDecoration(
                      labelText: "Duration (Aug 24 - Oct 24)",
                    ),
                  ),
                  TextField(
                    controller: periodController,
                    decoration: const InputDecoration(
                      labelText: "Period (3 mos)",
                    ),
                  ),
                  TextField(
                    controller: respController,
                    decoration: const InputDecoration(
                      labelText: "Responsibilities (comma separated)",
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                // Inside _addExperienceDialog -> ElevatedButton onPressed
                onPressed: () async {
                  // 1. Create temporary model without ID
                  final tempExp = ExperienceModel(
                    role: roleController.text,
                    company: companyController.text,
                    duration: durationController.text,
                    period: periodController.text,
                    responsibilities: respController.text.split(','),
                  );

                  // 2. Save locally and get the auto-generated ID from SQLite
                  int localId = await _experienceDB.insertExperience(tempExp);

                  // 3. Create the ACTUAL model including the ID to sync to Firebase
                  // Since 'id' is final, we create a new object
                  final finalExp = ExperienceModel(
                    id: localId, // ✅ Pass the ID here
                    role: tempExp.role,
                    company: tempExp.company,
                    duration: tempExp.duration,
                    period: tempExp.period,
                    responsibilities: tempExp.responsibilities,
                  );

                  // 4. Sync to Cloud
                  await FirestoreService().addExperience(finalExp);

                  await _loadAllData();
                  Navigator.pop(context);
                  _showSnackBar("Experience saved to cloud!");
                },
                child: const Text("Add"),
              ),
            ],
          ),
    );
  }

  void _editExperienceDetails(ExperienceModel exp) {
    final roleController = TextEditingController(text: exp.role);
    final companyController = TextEditingController(text: exp.company);
    final durationController = TextEditingController(text: exp.duration);
    final periodController = TextEditingController(text: exp.period);
    final respController = TextEditingController(
      text: exp.responsibilities.join(', '),
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Edit Experience"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: roleController,
                    decoration: const InputDecoration(labelText: "Role"),
                  ),
                  TextField(
                    controller: companyController,
                    decoration: const InputDecoration(labelText: "Company"),
                  ),
                  TextField(
                    controller: durationController,
                    decoration: const InputDecoration(labelText: "Duration"),
                  ),
                  TextField(
                    controller: periodController,
                    decoration: const InputDecoration(labelText: "Period"),
                  ),
                  TextField(
                    controller: respController,
                    decoration: const InputDecoration(
                      labelText: "Responsibilities (comma separated)",
                    ),
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
                  final updatedExp = ExperienceModel(
                    id: exp.id, // ✅ Keep the same ID so SQLite knows which row to update
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

                  await _experienceDB.updateExperience(updatedExp);
                  await _loadAllData(); // ✅ Refresh the UI list
                  Navigator.pop(context);
                  _showSnackBar("Experience updated!");
                },
                child: const Text("Update"),
              ),
            ],
          ),
    );
  }

  void _deleteExperience(int index) {
    setState(() => _experiences.removeAt(index));
  }

  // lib/home_screen.dart

  void _addEducation() {
    final schoolController = TextEditingController();
    final degreeController = TextEditingController();
    final yearsController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Add Education"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: schoolController,
                  decoration: const InputDecoration(
                    labelText: "School/University",
                  ),
                ),
                TextField(
                  controller: degreeController,
                  decoration: const InputDecoration(labelText: "Degree"),
                ),
                TextField(
                  controller: yearsController,
                  decoration: const InputDecoration(
                    labelText: "Years (e.g., 2020-2024)",
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (schoolController.text.isEmpty ||
                      degreeController.text.isEmpty) {
                    _showSnackBar("Please fill in the details");
                    return;
                  }

                  final tempEdu = EducationModel(
                    institution: schoolController.text.trim(),
                    degree: degreeController.text.trim(),
                    years: yearsController.text.trim(),
                    level: '',
                  );

                  try {
                    // 1. Save to Local SQLite and get the ID
                    int localId = await _educationDB.insertEducation(tempEdu);

                    // 2. Create actual model with ID
                    final finalEdu = EducationModel(
                      id: localId,
                      institution: tempEdu.institution,
                      degree: tempEdu.degree,
                      years: tempEdu.years,
                      level: tempEdu.level,
                    );

                    // 3. ✅ IMMEDIATE UI UPDATE (Optimistic UI)
                    setState(() {
                      _dbEducation.add(finalEdu);
                    });

                    // 4. Close the dialog right away
                    Navigator.pop(context);

                    // 5. Sync to Firebase in the background
                    await FirestoreService().addEducation(finalEdu);

                    _showSnackBar("Education added!");
                  } catch (e) {
                    _showSnackBar("Error: $e");
                  }
                },
                child: const Text("Add"),
              ),
            ],
          ),
    );
  }

  void _editEducation(int index) {
    final edu = _education[index];
    final schoolController = TextEditingController(text: edu["school"]);
    final degreeController = TextEditingController(text: edu["degree"]);
    final yearsController = TextEditingController(text: edu["years"]);

    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text("Edit Education"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: schoolController,
                    decoration: const InputDecoration(
                      labelText: "School",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: degreeController,
                    decoration: const InputDecoration(
                      labelText: "Degree",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: yearsController,
                    decoration: const InputDecoration(
                      labelText: "Years",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _education[index] = {
                        "school": schoolController.text,
                        "degree": degreeController.text,
                        "years": yearsController.text,
                      };
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
      );
    });
  }

  void _deleteEducation(int index) {
    setState(() => _education.removeAt(index));
  }

  // FIX 2: _addSkill Action
  void _addSkill() {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Add Skill"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Skill"),
                ),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: "Category"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  // 1. Create the model
                  final newSkill = SkillModel(
                    name: nameController.text,
                    category: categoryController.text,
                    percentage: 80,
                  );

                  // 2. Save it (Async work)
                  await _skillService.saveSkill(newSkill);

                  // 3. Refresh list (Async work)
                  final updatedList = await _skillService.fetchSkills();

                  // 4. Update UI (Sync work)
                  if (mounted) {
                    setState(() {
                      _skills = updatedList;
                    });
                  }
                  Navigator.pop(context);
                },
                child: const Text("Add"),
              ),
            ],
          ),
    );
  }

  void _deleteSkill(int index) async {
    final skillId = _skills[index].id!;
    await _skillDB.deleteSkill(skillId);
    await _loadSkills();
  }

  void _showEditSkillDialog(SkillModel skill) {
    final nameController = TextEditingController(text: skill.name);
    final categoryController = TextEditingController(text: skill.category);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Edit Skill"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Skill"),
                ),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: "Category"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              // Example of how to call it in your HomeScreen dialog
              ElevatedButton(
                onPressed: () async {
                  final updatedSkill = SkillModel(
                    id: skill.id, // 👈 IMPORTANT: Must pass the existing ID
                    name: nameController.text,
                    category: categoryController.text,
                    percentage: skill.percentage,
                  );

                  await _skillDB.updateSkill(
                    updatedSkill,
                  ); // This will now work!
                  _loadSkills();
                  Navigator.pop(context);
                },
                child: const Text("Update"),
              ),
            ],
          ),
    );
  }

  void _addProject() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final techController = TextEditingController();
    final urlController = TextEditingController();
    String category = 'Mobile';

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: const Text("Add Project"),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(labelText: "Title"),
                        ),
                        TextField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            labelText: "Description",
                          ),
                          maxLines: 3,
                        ),
                        TextField(
                          controller: techController,
                          decoration: const InputDecoration(
                            labelText: "Tech Stack",
                          ),
                        ),
                        TextField(
                          controller: urlController,
                          decoration: const InputDecoration(
                            labelText: "Github URL",
                          ),
                        ),
                        DropdownButton<String>(
                          value: category,
                          isExpanded: true,
                          items:
                              ['Mobile', 'Backend', 'Full Stack']
                                  .map(
                                    (val) => DropdownMenuItem(
                                      value: val,
                                      child: Text(val),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (val) => setDialogState(() => category = val!),
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
                        final newProject = ProjectModel(
                          title: titleController.text,
                          description: descriptionController.text,
                          techStack: techController.text,
                          githubUrl: urlController.text,
                          category: category,
                        );
                        await _projectDB.insertProject(newProject);
                        await _loadAllData(); // ✅ Refresh UI
                        Navigator.pop(context);
                      },
                      child: const Text("Add"),
                    ),
                  ],
                ),
          ),
    );
  }

  void _editProjectDetails(ProjectModel project) {
    final titleController = TextEditingController(text: project.title);
    final descController = TextEditingController(text: project.description);
    final techController = TextEditingController(text: project.techStack);
    final urlController = TextEditingController(text: project.githubUrl);
    String category = project.category;

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: const Text("Edit Project"),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(labelText: "Title"),
                        ),
                        TextField(
                          controller: descController,
                          decoration: const InputDecoration(
                            labelText: "Description",
                          ),
                          maxLines: 3,
                        ),
                        TextField(
                          controller: techController,
                          decoration: const InputDecoration(
                            labelText: "Tech Stack",
                          ),
                        ),
                        TextField(
                          controller: urlController,
                          decoration: const InputDecoration(
                            labelText: "Github URL",
                          ),
                        ),
                        DropdownButton<String>(
                          value: category,
                          isExpanded: true,
                          items:
                              ['Mobile', 'Backend', 'Full Stack']
                                  .map(
                                    (val) => DropdownMenuItem(
                                      value: val,
                                      child: Text(val),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (val) => setDialogState(() => category = val!),
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
                        final updated = ProjectModel(
                          id: project.id,
                          title: titleController.text,
                          description: descController.text,
                          techStack: techController.text,
                          githubUrl: urlController.text,
                          category: category,
                        );
                        await _projectDB.updateProject(updated);
                        await _loadAllData();
                        Navigator.pop(context);
                      },
                      child: const Text("Update"),
                    ),
                  ],
                ),
          ),
    );
  }

  void _deleteProject(int index) {
    setState(() => _projects.removeAt(index));
  }

  void _addCertification() {
    final titleController = TextEditingController();
    final issuerController = TextEditingController();
    final dateController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Add Certification"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                TextField(
                  controller: issuerController,
                  decoration: const InputDecoration(labelText: "Issuer"),
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: "Date (e.g. Oct 2024)",
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final newCert = CertificationModel(
                    title: titleController.text,
                    issuer: issuerController.text,
                    date: dateController.text,
                  );
                  await _certDB.insertCertification(newCert);
                  await _loadAllData(); // ✅ Refresh UI
                  Navigator.pop(context);
                },
                child: const Text("Add"),
              ),
            ],
          ),
    );
  }

  void _editCertification(int index) {
    final cert = _certifications[index];
    final titleController = TextEditingController(text: cert["title"]);
    final issuerController = TextEditingController(text: cert["issuer"]);
    final dateController = TextEditingController(text: cert["date"]);

    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text("Edit Certification"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: "Certification Title",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: issuerController,
                    decoration: const InputDecoration(
                      labelText: "Issuer",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      labelText: "Issue Date",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _certifications[index] = {
                        "title": titleController.text,
                        "issuer": issuerController.text,
                        "date": dateController.text,
                      };
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
      );
    });
  }

  void _deleteCertification(int index) {
    setState(() => _certifications.removeAt(index));
  }

  void _showContactInfo() {
    final emailController = TextEditingController(text: _email);
    final phoneController = TextEditingController(text: _phone);
    final linkController = TextEditingController(text: _linkedIn);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Edit Contact Info"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: "Phone"),
                ),
                TextField(
                  controller: linkController,
                  decoration: const InputDecoration(labelText: "LinkedIn URL"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final updated = ProfileModel(
                    name: _name,
                    headline: _headline,
                    location: _location,
                    about: _about,
                    profileImagePath: _mobileImage?.path,
                    email: emailController.text,
                    phone: phoneController.text,
                    linkedIn: linkController.text,
                    isOpenToWork: _isOpenToWork ? 1 : 0,
                  );
                  await _profileDB.updateProfile(updated);
                  await _loadAllData();
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }

  Widget _addSectionTile(
    String title,
    IconData icon,
    String dbField,
    bool isAlreadyVisible,
  ) {
    return ListTile(
      leading: Icon(icon, color: isAlreadyVisible ? Colors.green : Colors.blue),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color:
              themeNotifier.value == ThemeMode.dark
                  ? Colors.white70
                  : const Color(
                    0xFF475569,
                  ), // 👈 Slate Blue-Grey for Light Mode
          fontSize: 14,
        ),
      ),
      subtitle: Text(isAlreadyVisible ? "Already added" : "Click to add"),
      onTap:
          isAlreadyVisible
              ? null
              : () async {
                final profile = await _profileDB.getProfile();
                if (profile != null) {
                  final updatedMap = profile.toMap();
                  updatedMap[dbField] = 1;

                  final updatedProfile = ProfileModel.fromMap(updatedMap);

                  // 1. Save to Local & Cloud
                  await _profileDB.updateProfile(updatedProfile);
                  await FirestoreService().saveProfile(updatedProfile);

                  // ✅ 2. FIX: Update the local variables immediately so the UI rebuilds
                  setState(() {
                    if (dbField == "showLanguages") _showLanguages = true;
                    if (dbField == "showAwards") _showAwards = true;
                    //if (dbField == "showVolunteer") _showVolunteer = true;
                  });

                  // 3. Reload everything else
                  await _loadAllData();
                }
                Navigator.pop(context);
              },
    );
  }

  // Dynamic Section Dialog
  void _showAddSectionDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF1E1E2E),
            title: Text(
              "Add Profile Section",
              style: GoogleFonts.poppins(
                color:
                    themeNotifier.value == ThemeMode.dark
                        ? Colors.white70
                        : const Color(
                          0xFF475569,
                        ), // 👈 Slate Blue-Grey for Light Mode
                fontSize: 14,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _addSectionTile(
                  "Languages",
                  Icons.language,
                  "showLanguages",
                  _showLanguages,
                ),
                // _addSectionTile(
                //   "Volunteer Experience",
                //   Icons.volunteer_activism,
                //   "showVolunteer",
                //   _showVolunteer,
                //),
                _addSectionTile(
                  "Honors & Awards",
                  Icons.emoji_events,
                  "showAwards",
                  _showAwards,
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildAddSectionTile(String title, IconData icon, String dbField) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      onTap: () async {
        // ✅ Update the database to show this section
        final profile = await _profileDB.getProfile();
        if (profile != null) {
          final updatedMap = profile.toMap();
          updatedMap[dbField] = 1; // Set to visible
          await _profileDB.updateProfile(ProfileModel.fromMap(updatedMap));
          await _loadAllData(); // Refresh UI
        }
        Navigator.pop(context);
      },
    );
  }

  void _showMoreOptions() {
    // showModalBottomSheet(
    //   context: context,
    //   backgroundColor: const Color(0xFF1E1E2E), // Matches your theme
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    //   ),
    //   builder:
    //       (context) => Container(
    //         padding: const EdgeInsets.all(20),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             // --- Updated Backup ListTile ---
    //             ListTile(
    //               leading: const Icon(Icons.cloud_upload, color: Colors.blue),
    //               title: const Text(
    //                 "Backup all data to Firebase",
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //               onTap: () async {
    //                 Navigator.pop(context); // Close the bottom sheet

    //                 // 1. Show the Loading Dialog
    //                 _showSyncingDialog();

    //                 try {
    //                   // 2. Start Migration logic from your MigrationService
    //                   await MigrationService().migrateAllData();

    //                   // 3. Close the Loading Dialog only if the widget is still active
    //                   if (mounted) Navigator.pop(context);

    //                   // 4. Show the success SnackBar
    //                   ScaffoldMessenger.of(context).showSnackBar(
    //                     SnackBar(
    //                       content: const Text("All data is now in the cloud!"),
    //                       backgroundColor: Colors.green,
    //                       behavior: SnackBarBehavior.floating,
    //                       action: SnackBarAction(
    //                         label: "OK",
    //                         textColor: Colors.white,
    //                         onPressed: () {},
    //                       ),
    //                     ),
    //                   );
    //                 } catch (e) {
    //                   // Close the dialog if an error occurs
    //                   if (mounted) Navigator.pop(context);
    //                   _showSnackBar("Sync failed: $e");
    //                 }
    //               },
    //             ),

    //             // --- Other Options (Share, QR, etc.) ---
    //             ListTile(
    //               leading: const Icon(Icons.share, color: Colors.white70),
    //               title: const Text(
    //                 "Share profile",
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //               onTap: () {
    //                 Navigator.pop(context);
    //                 _showSnackBar("Share profile clicked");
    //               },
    //             ),
    //             ListTile(
    //               leading: const Icon(Icons.qr_code, color: Colors.white70),
    //               title: const Text(
    //                 "QR code",
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //               onTap: () {
    //                 Navigator.pop(context);
    //                 _showSnackBar("QR code ready");
    //               },
    //             ),
    //             ListTile(
    //               leading: const Icon(Icons.download, color: Colors.white70),
    //               title: const Text(
    //                 "Save as PDF",
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //               onTap: () {
    //                 Navigator.pop(context);
    //                 _showSnackBar("Generating PDF...");
    //               },
    //             ),
    //             ListTile(
    //               leading: const Icon(Icons.visibility, color: Colors.white70),
    //               title: const Text(
    //                 "View in profile mode",
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //               onTap: () {
    //                 Navigator.pop(context);
    //                 _showSnackBar("Entering Profile Mode");
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    // );
  }

  void _showAddActivityDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF1E1E2E),
            title: const Text(
              "Share an Update",
              style: TextStyle(color: Colors.white),
            ),
            content: TextField(
              controller: controller,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "What's on your mind?",
                hintStyle: TextStyle(color: Colors.white24),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final newActivity = ActivityModel(
                    content: controller.text,
                    date: DateTime.now().toString().substring(
                      0,
                      10,
                    ), // Simplifies date to YYYY-MM-DD
                  );

                  // 1. Save to Firebase
                  await FirestoreService().addActivity(newActivity);

                  // 2. Refresh local data
                  await _loadAllData();

                  Navigator.pop(context);
                  _showSnackBar("Activity posted!");
                },
                child: const Text("Post"),
              ),
            ],
          ),
    );
  }

  void _showSyncingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // User cannot tap outside to close it
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF1E1E2E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(color: Colors.blue),
                const SizedBox(height: 20),
                Text(
                  "Syncing Portfolio to Cloud...",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Updating your skills, projects, and experience",
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ================= HELPER METHODS =================
  DecorationImage? _getCoverImage() {
    if (kIsWeb && _webCoverImage != null) {
      return DecorationImage(
        image: MemoryImage(_webCoverImage!),
        fit: BoxFit.cover,
      );
    } else if (!kIsWeb && _mobileCoverImage != null) {
      return DecorationImage(
        image: FileImage(_mobileCoverImage!),
        fit: BoxFit.cover,
      );
    }
    return null;
  }

  ImageProvider? _getProfileImage() {
    if (_savedImagePath != null && _savedImagePath!.isNotEmpty) {
      if (_savedImagePath!.startsWith('http')) {
        return NetworkImage(_savedImagePath!); // Loads from Firebase
      } else {
        return FileImage(File(_savedImagePath!)); // Loads from local path
      }
    }
    return null; // Shows default person icon
  }

  @override
  void dispose() {
    _floatingController.dispose();
    super.dispose();
  }
}
