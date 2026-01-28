import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for HapticFeedback
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/data/models/contact_model.dart';
import 'package:my_portfolio/services/firestore_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';
import 'dart:math' as math;

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // Helper for SnackBars
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF6366F1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // Helper for Success Dialog
  void _showSuccessDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder:
          (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AlertDialog(
              backgroundColor: isDark ? const Color(0xFF1E1E2E) : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                        Icons.check_circle_outline_rounded,
                        color: Colors.greenAccent,
                        size: 80,
                      )
                      .animate()
                      .scale(duration: 600.ms, curve: Curves.elasticOut)
                      .shimmer(delay: 800.ms),
                  const SizedBox(height: 20),
                  Text(
                    "Message Sent!",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Thanks for reaching out! I will get back to you soon.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Awesome!",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  // Logic to handle Resume Download (Google Drive Direct Link)
  Future<void> _handleResumeDownload() async {
    HapticFeedback.lightImpact(); // Tactile feedback
    const String googleDriveUrl =
        "https://drive.google.com/uc?export=download&id=1zN6KWuqXKbzZYWJ9jCxjlPpAf-IAXrhI";

    final Uri uri = Uri.parse(googleDriveUrl);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      _showSnackBar("Error: Could not open download link.");
    }
  }

  // Logic for opening social links
  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showSnackBar("Could not open link.");
    }
  }

  // Logic for form submission to Firebase
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      try {
        final msg = ContactMessage(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          message: _messageController.text.trim(),
          timestamp: DateTime.now(),
        );

        await FirestoreService().sendContactMessage(msg);

        if (mounted) {
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
          _showSuccessDialog();
        }
      } catch (e) {
        _showSnackBar("Firestore Error: $e");
      } finally {
        if (mounted) setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 600;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF030712) : const Color(0xFFF1F5F9),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: isDark ? Colors.white : Colors.black),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _waveController,
              builder: (context, child) {
                return CustomPaint(
                  painter: WavePainter(
                    waveValue: _waveController.value,
                    color: const Color(
                      0xFF6366F1,
                    ).withOpacity(isDark ? 0.05 : 0.1),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  _buildHeader(isMobile, isDark),
                  const SizedBox(height: 40),
                  _buildMainContent(isMobile, isDark),
                  const SizedBox(height: 50),
                  _buildSocialGrid(isMobile, isDark),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isMobile, bool isDark) {
    return Column(
      children: [
        const Icon(
          Icons.alternate_email,
          color: Color(0xFF6366F1),
          size: 40,
        ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 2.seconds),
        const SizedBox(height: 16),
        Text(
          "Let's Build Together",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: isDark ? Colors.white : Colors.black,
            fontSize: isMobile ? 32 : 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Open for collaborations and full-stack opportunities.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDark ? Colors.white54 : Colors.black54,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 25),
        // ✨ DYNAMIC RESUME BUTTON
        GestureDetector(
          onTap: _handleResumeDownload,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors:
                      isDark
                          ? [const Color(0xFF6366F1), const Color(0xFF4338CA)]
                          : [const Color(0xFF4F46E5), const Color(0xFF3730A3)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6366F1).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.file_download_done_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "GET MY CV",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ).animate().scale(
          delay: 500.ms,
          duration: 600.ms,
          curve: Curves.elasticOut,
        ),
      ],
    ).animate().fadeIn().slideY(begin: 0.1);
  }

  Widget _buildMainContent(bool isMobile, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color:
            isDark
                ? Colors.white.withOpacity(0.03)
                : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.blueAccent.withOpacity(0.1),
        ),
        boxShadow:
            isDark ? [] : [BoxShadow(color: Colors.black12, blurRadius: 20)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildModernField(
                  controller: _nameController,
                  label: "Name",
                  icon: Icons.person_outline,
                  isDark: isDark,
                ),
                const SizedBox(height: 20),
                _buildModernField(
                  controller: _emailController,
                  label: "Email",
                  icon: Icons.mail_outline,
                  isDark: isDark,
                ),
                const SizedBox(height: 20),
                _buildModernField(
                  controller: _messageController,
                  label: "Message",
                  icon: Icons.chat_bubble_outline,
                  maxLines: 4,
                  isDark: isDark,
                ),
                const SizedBox(height: 30),
                _isSubmitting
                    ? const CircularProgressIndicator(color: Color(0xFF6366F1))
                    : _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildModernField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isDark,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: isDark ? Colors.white38 : Colors.black45),
        prefixIcon: Icon(icon, color: const Color(0xFF6366F1), size: 20),
        filled: true,
        fillColor:
            isDark
                ? Colors.white.withOpacity(0.02)
                : Colors.black.withOpacity(0.02),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isDark ? Colors.white10 : Colors.black12,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
      ),
      validator: (val) => val!.isEmpty ? "Required" : null,
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6366F1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          "SEND MESSAGE",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialGrid(bool isMobile, bool isDark) {
    final socials = [
      {
        'name': 'LinkedIn',
        'icon': Icons.business,
        'url': 'https://www.linkedin.com/in/kunal-sonawane-732ba6224/',
      },
      {
        'name': 'GitHub',
        'icon': Icons.code,
        'url': 'https://github.com/kunalll123',
      },
      {
        'name': 'WhatsApp',
        'icon': Icons.chat,
        'url': 'https://wa.me/qr/AR4D6Q52XZERB1',
      },
    ];

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children:
          socials.asMap().entries.map((e) {
            return _buildSocialIcon(
              e.value['icon'] as IconData,
              e.key,
              e.value['url'] as String,
              isDark,
            );
          }).toList(),
    );
  }

  Widget _buildSocialIcon(IconData icon, int index, String url, bool isDark) {
    return GestureDetector(
      onTap: () => _openLink(url),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color:
              isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.black.withOpacity(0.05),
          shape: BoxShape.circle,
          border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
        ),
        child: Icon(icon, color: isDark ? Colors.white70 : Colors.black54),
      ),
    ).animate().scale(
      delay: (index * 100).ms,
      curve: Curves.easeOutBack,
      duration: 600.ms,
    );
  }
}

class WavePainter extends CustomPainter {
  final double waveValue;
  final Color color;

  WavePainter({required this.waveValue, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;
    final path = Path();

    final yOffset = size.height * 0.85;
    path.moveTo(0, yOffset);

    for (double i = 0; i <= size.width; i++) {
      path.lineTo(
        i,
        yOffset +
            math.sin(
                  (i / size.width * 2 * math.pi) + (waveValue * 2 * math.pi),
                ) *
                20,
      );
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) => true;
}
