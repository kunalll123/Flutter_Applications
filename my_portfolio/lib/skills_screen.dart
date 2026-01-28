import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'dart:math' as math;

import 'package:my_portfolio/data/data_source/skill_db.dart';
import 'package:my_portfolio/data/models/skill_model.dart';
import 'package:my_portfolio/main.dart'; // ✅ Import to access themeNotifier

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  String _selectedCategory = 'All';

  final SkillDB _skillDB = SkillDB();
  List<SkillModel> skills = [];

  @override
  void initState() {
    super.initState();
    loadSkills();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
  }

  Future<void> loadSkills() async {
    final data = await _skillDB.getSkills();
    setState(() {
      skills = data;
    });
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    super.dispose();
  }

  List<SkillModel> get filteredSkills {
    if (_selectedCategory == 'All') return skills;
    return skills
        .where((skill) => getCategory(skill.name) == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 600;

    // ✅ Listen to theme changes
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, child) {
        final isDark = mode == ThemeMode.dark;

        return Scaffold(
          // ✅ Dynamic Background Color
          backgroundColor:
              isDark ? const Color(0xFF020617) : const Color(0xFFF1F5F9),
          extendBodyBehindAppBar: true,
          appBar: _buildAppBar(isDark),
          body: Stack(
            children: [
              // 1. Particle Background (Matching Home Screen)
              ...List.generate(
                15,
                (index) => _buildFloatingParticle(size, isDark),
              ),

              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : 60,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader(
                        "Technical Arsenal",
                        "Engineering scalable solutions with modern full-stack technologies.",
                        isDark,
                      ),
                      const SizedBox(height: 40),

                      // 2. Interactive Category Filter
                      _buildFilterChips(isDark),
                      const SizedBox(height: 40),

                      // 3. Glassmorphic Skill Grid
                      _buildResponsiveGrid(isMobile, isDark),

                      const SizedBox(height: 60),

                      // 4. Achievement Summary
                      _buildSummaryStats(isMobile, isDark),
                      const SizedBox(height: 40),
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

  Widget _buildFloatingParticle(Size size, bool isDark) {
    final random = math.Random();
    double startX = random.nextDouble() * size.width;
    double startY = random.nextDouble() * size.height;
    return AnimatedBuilder(
      animation: _backgroundController,
      builder: (context, child) {
        return Positioned(
          left: (startX + (_backgroundController.value * 120)) % size.width,
          top: (startY + (_backgroundController.value * 70)) % size.height,
          child: Container(
            width: 2,
            height: 2,
            decoration: BoxDecoration(
              // ✅ Dynamic Particle Color
              color:
                  isDark
                      ? Colors.indigoAccent.withOpacity(0.3)
                      : Colors.blueAccent.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(bool isDark) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: isDark ? Colors.white : Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        "TECH STACK",
        style: GoogleFonts.orbitron(
          color: isDark ? Colors.white : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w800,
          letterSpacing: 4,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 38,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: isDark ? Colors.white54 : Colors.black54,
            height: 1.5,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.1);
  }

  Widget _buildFilterChips(bool isDark) {
    final categories = ['All', 'Mobile', 'Backend', 'Tools'];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children:
          categories.map((cat) {
            final isSelected = _selectedCategory == cat;
            return GestureDetector(
              onTap: () => setState(() => _selectedCategory = cat),
              child: AnimatedContainer(
                duration: 400.ms,
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  gradient:
                      isSelected
                          ? const LinearGradient(
                            colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
                          )
                          : null,
                  // ✅ Dynamic Chip Background
                  color:
                      isSelected
                          ? null
                          : (isDark
                              ? Colors.white.withOpacity(0.05)
                              : Colors.white),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color:
                        isSelected
                            ? Colors.transparent
                            : (isDark ? Colors.white10 : Colors.black12),
                  ),
                  boxShadow:
                      isSelected
                          ? [
                            BoxShadow(
                              color: const Color(0xFF6366F1).withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ]
                          : [],
                ),
                child: Text(
                  cat,
                  style: GoogleFonts.orbitron(
                    color:
                        isSelected
                            ? Colors.white
                            : (isDark ? Colors.white60 : Colors.black54),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildResponsiveGrid(bool isMobile, bool isDark) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : 3,
        mainAxisExtent: 200,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
      ),
      itemCount: filteredSkills.length,
      itemBuilder: (context, index) {
        return _buildSkillCard(filteredSkills[index], index, isDark);
      },
    );
  }

  Widget _buildSkillCard(SkillModel skill, int index, bool isDark) {
    final color = getColor(skill.name);
    final icon = getIcon(skill.name);

    return Container(
          decoration: BoxDecoration(
            // ✅ Dynamic Card Glass Background
            color:
                isDark
                    ? Colors.white.withOpacity(0.03)
                    : Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
            ),
            boxShadow:
                isDark
                    ? []
                    : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: color, size: 28),
                    ),
                    const Spacer(),
                    Text(
                      skill.name,
                      style: GoogleFonts.poppins(
                        color: isDark ? Colors.white : Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildModernProgressBar(
                      skill.percentage / 100,
                      color,
                      isDark,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(delay: (index * 80).ms)
        .scale(begin: const Offset(0.9, 0.9));
  }

  Widget _buildModernProgressBar(double level, Color color, bool isDark) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "PROWESS",
              style: GoogleFonts.orbitron(
                color: isDark ? Colors.white30 : Colors.black26,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${(level * 100).toInt()}%",
              style: GoogleFonts.orbitron(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            AnimatedContainer(
              duration: 1500.ms,
              height: 6,
              width: 250 * level, // Adjusted for responsiveness
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.5)],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: color.withOpacity(0.3), blurRadius: 8),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryStats(bool isMobile, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStat("${skills.length}", "TECH STACK", isDark),
          _buildStat("MCA", "EDUCATION", isDark),
          _buildStat("Pune", "LOCATION", isDark),
        ],
      ),
    );
  }

  Widget _buildStat(String val, String label, bool isDark) {
    return Column(
      children: [
        Text(
          val,
          style: GoogleFonts.orbitron(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: isDark ? Colors.white38 : Colors.black38,
            fontSize: 10,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  // Helpers remain the same...
  String getCategory(String name) {
    name = name.toLowerCase();
    if ([
      'flutter',
      'dart',
      'firebase',
      'rest api',
      'mobile',
    ].any((e) => name.contains(e)))
      return 'Mobile';
    if ([
      'java',
      'spring',
      'mysql',
      'sql',
      'backend',
    ].any((e) => name.contains(e)))
      return 'Backend';
    return 'Tools';
  }

  IconData getIcon(String name) {
    name = name.toLowerCase();
    if (name.contains('flutter')) return Icons.bolt_rounded;
    if (name.contains('java')) return Icons.coffee_rounded;
    if (name.contains('spring')) return Icons.eco_rounded;
    if (name.contains('sql')) return Icons.storage_rounded;
    if (name.contains('firebase')) return Icons.cloud_done_rounded;
    return Icons.code_rounded;
  }

  Color getColor(String name) {
    name = name.toLowerCase();
    if (name.contains('flutter')) return const Color(0xFF02569B);
    if (name.contains('java')) return const Color(0xFFF89820);
    if (name.contains('spring')) return const Color(0xFF6DB33F);
    if (name.contains('firebase')) return const Color(0xFFFFCA28);
    return const Color(0xFF6366F1);
  }
}
