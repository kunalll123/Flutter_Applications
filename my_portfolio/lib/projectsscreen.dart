import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:my_portfolio/data/data_source/project_db.dart';
import 'package:my_portfolio/data/models/project_model.dart';
import 'package:my_portfolio/services/firestore_service.dart';
import 'package:my_portfolio/main.dart'; // ✅ Import to access themeNotifier

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  String _selectedFilter = 'All';
  final ProjectDB _projectDB = ProjectDB();
  List<ProjectModel> projects = [];

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
    loadProjects();
  }

  Future<void> loadProjects() async {
    final data = await _projectDB.getProjects();
    if (mounted) {
      setState(() => projects = data);
    }
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // ✅ Listen to global theme changes
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, child) {
        final isDark = mode == ThemeMode.dark;
        final isMobile = size.width <= 600;

        return Scaffold(
          // ✅ Dynamic Background Colors
          backgroundColor:
              isDark ? const Color(0xFF020617) : const Color(0xFFF1F5F9),
          body: Stack(
            children: [
              _buildFloatingParticles(size, isDark),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomScrollView(
                    slivers: [
                      _buildHeader(isMobile, isDark),
                      _buildFilterSection(isDark),
                      _buildProjectList(isMobile, isDark),
                      const SliverToBoxAdapter(child: SizedBox(height: 100)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(bool isMobile, bool isDark) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "PROJECTS",
              style: GoogleFonts.orbitron(
                color: const Color(0xFF6366F1),
                letterSpacing: 8,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "The Forge of\nInnovation.",
              style: GoogleFonts.poppins(
                color: isDark ? Colors.white : const Color(0xFF1E293B),
                fontSize: isMobile ? 36 : 52,
                fontWeight: FontWeight.w900,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(bool isDark) {
    final filters = ['All', 'Mobile', 'Backend', 'Full Stack'];
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          itemBuilder: (context, index) {
            bool selected = _selectedFilter == filters[index];
            return GestureDetector(
              onTap: () => setState(() => _selectedFilter = filters[index]),
              child: AnimatedContainer(
                duration: 300.ms,
                margin: const EdgeInsets.only(right: 15, bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color:
                      selected
                          ? const Color(0xFF6366F1)
                          : (isDark
                              ? Colors.white.withOpacity(0.05)
                              : Colors.white),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color:
                        selected
                            ? Colors.white30
                            : (isDark
                                ? Colors.white10
                                : Colors.black.withOpacity(0.05)),
                  ),
                  boxShadow:
                      selected
                          ? [
                            BoxShadow(
                              color: const Color(0xFF6366F1).withOpacity(0.3),
                              blurRadius: 10,
                            ),
                          ]
                          : [],
                ),
                alignment: Alignment.center,
                child: Text(
                  filters[index],
                  style: GoogleFonts.poppins(
                    color:
                        selected
                            ? Colors.white
                            : (isDark ? Colors.white54 : Colors.black54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProjectList(bool isMobile, bool isDark) {
    final filtered =
        _selectedFilter == 'All'
            ? projects
            : projects.where((p) => p.category == _selectedFilter).toList();

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: _buildProjectCard(filtered[index], index, isMobile, isDark),
        );
      }, childCount: filtered.length),
    );
  }

  Widget _buildProjectCard(
    ProjectModel project,
    int index,
    bool isMobile,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
        color:
            isDark
                ? Colors.white.withOpacity(0.03)
                : Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color:
              isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.blue.withOpacity(0.05),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _categoryChip(project.category),
                    Row(
                      children: [
                        IconButton(
                          onPressed:
                              () => _showProjectDialog(
                                project: project,
                                isDark: isDark,
                              ),
                          icon: Icon(
                            Icons.edit_rounded,
                            color: isDark ? Colors.white24 : Colors.black26,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _deleteProject(project.id!),
                          icon: const Icon(
                            Icons.delete_forever_rounded,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  project.title,
                  style: GoogleFonts.poppins(
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  project.description,
                  style: GoogleFonts.poppins(
                    color: isDark ? Colors.white60 : const Color(0xFF475569),
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 25),
                _buildTechBadges(project.techStack, isDark),
                const SizedBox(height: 30),
                _buildActionButtons(project.githubUrl),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: (index * 100).ms).slideY(begin: 0.1);
  }

  Widget _categoryChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.4)),
      ),
      child: Text(
        label.toUpperCase(),
        style: GoogleFonts.orbitron(
          color: const Color(0xFF6366F1),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTechBadges(String stack, bool isDark) {
    final list = stack.split(',');
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children:
          list
              .map(
                (t) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isDark
                            ? Colors.white.withOpacity(0.05)
                            : Colors.black.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    t.trim(),
                    style: GoogleFonts.poppins(
                      color: isDark ? Colors.white38 : Colors.black45,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }

  Widget _buildActionButtons(String url) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        decoration: BoxDecoration(
          color: const Color(0xFF6366F1),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6366F1).withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "VIEW SOURCE CODE",
              style: GoogleFonts.orbitron(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.code, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingParticles(Size size, bool isDark) {
    return Stack(
      children: List.generate(15, (index) {
        final random = math.Random();
        return AnimatedBuilder(
          animation: _backgroundController,
          builder: (context, child) {
            return Positioned(
              left:
                  (random.nextDouble() * size.width +
                      (_backgroundController.value * 50)) %
                  size.width,
              top:
                  (random.nextDouble() * size.height +
                      (_backgroundController.value * 100)) %
                  size.height,
              child: Container(
                width: 2,
                height: 2,
                decoration: BoxDecoration(
                  color:
                      isDark
                          ? Colors.white10
                          : Colors.blueAccent.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        );
      }),
    );
  }

  // --- Methods for Logic ---

  void _showProjectDialog({ProjectModel? project, required bool isDark}) {
    final titleController = TextEditingController(text: project?.title);
    final descController = TextEditingController(text: project?.description);
    // ... complete your logic to handle adding/editing here ...
  }

  void _deleteProject(int id) async {
    await _projectDB.deleteProject(id);
    await FirestoreService().deleteDocument('projects', id.toString());
    loadProjects();
  }
}
