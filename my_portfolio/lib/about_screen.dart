import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';
// ✅ Import your main.dart to access themeNotifier
import 'package:my_portfolio/main.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;

  final List<Map<String, dynamic>> skills = [
    {'name': 'JAVA', 'color': const Color(0xFF2196F3)},
    {'name': 'FLUTTER', 'color': const Color(0xFF00BCD4)},
    {'name': 'SPRING BOOT', 'color': const Color(0xFF4CAF50)},
    {'name': 'MYSQL', 'color': const Color(0xFFFFA726)},
    {'name': 'FIREBASE', 'color': const Color(0xFFFFCA28)},
    {'name': 'REST API', 'color': const Color(0xFFE53935)},
    {'name': 'DART', 'color': const Color(0xFF3F51B5)},
    {'name': 'CLEAN ARCH', 'color': const Color(0xFF9C27B0)},
  ];

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width <= 600;

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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: isDark ? Colors.white : Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Stack(
            children: [
              // 1. Dynamic Background Particles
              ...List.generate(
                20,
                (index) => _buildFloatingParticle(size, isDark),
              ),

              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 80),

                    // 2. HERO SECTION
                    _buildHeroWithSkills(size, isMobile, isDark),

                    const SizedBox(height: 40),

                    // 3. Narrative Sections
                    _buildGlassSection(
                      title: "CORE IDENTITY",
                      content:
                          "I am Kunal Sonawane, a developer who believes in knowing the code till the core. My expertise lies in building full-stack ecosystems where Flutter's fluidity meets the robust scalability of Spring Boot and Java.",
                      isMobile: isMobile,
                      isDark: isDark,
                    ),

                    const SizedBox(height: 30),

                    _buildSkillGrid(isMobile, isDark),

                    const SizedBox(height: 60),
                    _buildExperienceSection(isMobile, isDark),
                    const SizedBox(height: 60),
                    _buildMissionCard(isMobile, isDark),
                    const SizedBox(height: 60),
                    _buildFooter(isMobile, isDark),
                    const SizedBox(height: 40),
                  ],
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
          left: (startX + (_backgroundController.value * 100)) % size.width,
          top: (startY + (_backgroundController.value * 50)) % size.height,
          child: Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              color:
                  isDark
                      ? Colors.white.withOpacity(0.2)
                      : Colors.blueAccent.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeroWithSkills(Size size, bool isMobile, bool isDark) {
    return Container(
      height: isMobile ? 450 : 550,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ...skills.asMap().entries.map((entry) {
            int idx = entry.key;
            var skill = entry.value;
            final List<Offset> positions = [
              const Offset(-130, -150),
              const Offset(130, -140),
              const Offset(-160, 20),
              const Offset(160, 40),
              const Offset(-120, 160),
              const Offset(120, 150),
              const Offset(0, -190),
              const Offset(0, 200),
            ];

            return Transform.translate(
                  offset: isMobile ? positions[idx] * 0.8 : positions[idx],
                  child: _buildSkillBadge(
                    skill['name'],
                    skill['color'],
                    isDark,
                  ),
                )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .shimmer(delay: (idx * 200).ms, duration: 2.seconds)
                .moveY(
                  begin: -5,
                  end: 5,
                  duration: 2.seconds,
                  curve: Curves.easeInOut,
                );
          }).toList(),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: isMobile ? 160 : 220,
                height: isMobile ? 160 : 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF6366F1), width: 4),
                  image: const DecorationImage(
                    image: AssetImage('assets/all assets/profile.jpeg'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withOpacity(0.4),
                      blurRadius: 40,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
              const SizedBox(height: 20),
              Text(
                "Kunal Sonawane",
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 28 : 40,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ).animate().fadeIn(delay: 300.ms),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillBadge(String name, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(isDark ? 0.1 : 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
      ),
      child: Text(
        name,
        style: GoogleFonts.orbitron(
          color: isDark ? Colors.white : color.withOpacity(0.8),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildGlassSection({
    required String title,
    required String content,
    required bool isMobile,
    required bool isDark,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color:
            isDark
                ? Colors.white.withOpacity(0.02)
                : Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.blueAccent.withOpacity(0.1),
        ),
        boxShadow:
            isDark
                ? []
                : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                  ),
                ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.orbitron(
              color: const Color(0xFF6366F1),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            content,
            style: GoogleFonts.poppins(
              color: isDark ? Colors.white70 : const Color(0xFF334155),
              fontSize: 15,
              height: 1.8,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1);
  }

  Widget _buildSkillGrid(bool isMobile, bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100),
      child: Wrap(
        spacing: 15,
        runSpacing: 15,
        alignment: WrapAlignment.center,
        children: skills.map((s) => _skillChip(s['name'], isDark)).toList(),
      ),
    );
  }

  Widget _skillChip(String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color:
            isDark
                ? Colors.white.withOpacity(0.05)
                : Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: isDark ? Colors.white : Colors.black87,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildExperienceSection(bool isMobile, bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "PROFESSIONAL LOG",
            style: GoogleFonts.orbitron(
              color: const Color(0xFF6366F1),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),
          _buildExpTile(
            "Flutter Intern",
            "Incubators System",
            "Aug 2024 - Oct 2024",
            isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildExpTile(String role, String company, String date, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color:
            isDark
                ? Colors.white.withOpacity(0.02)
                : Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            role,
            style: GoogleFonts.poppins(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "$company | $date",
            style: GoogleFonts.poppins(
              color: isDark ? Colors.white38 : Colors.black45,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionCard(bool isMobile, bool isDark) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: isDark ? Colors.transparent : Colors.white,
        gradient:
            isDark
                ? LinearGradient(
                  colors: [
                    const Color(0xFF6366F1).withOpacity(0.1),
                    Colors.transparent,
                  ],
                )
                : null,
        border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            "CODE. CORE. COMMIT.",
            style: GoogleFonts.orbitron(
              color: isDark ? Colors.white : const Color(0xFF6366F1),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Architecting digital futures through logic and design.",
            textAlign: TextAlign.center,
            style: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(bool isMobile, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialIcon(Icons.code, "https://github.com/kunalll123", isDark),
        const SizedBox(width: 25),
        _socialIcon(
          Icons.business,
          "https://linkedin.com/in/kunal-sonawane-732ba6224/",
          isDark,
        ),
        const SizedBox(width: 25),
        _socialIcon(Icons.email, "mailto:kunalsonawane5802@gmail.com", isDark),
      ],
    );
  }

  Widget _socialIcon(IconData icon, String url, bool isDark) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Icon(
        icon,
        color: isDark ? Colors.white70 : Colors.black54,
        size: 28,
      ),
    );
  }
}
