import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wroom_application/features/profiles/notification_preference_screen.dart';
import 'package:wroom_application/features/profiles/orders_screen.dart';
import 'package:wroom_application/features/profiles/referral_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // Function to pick image
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Curved Header and Profile Image
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF01C09A), // Brand Teal
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(40)),
                  ),
                  child: SafeArea(
                    child: Align(
                      alignment: Alignment.topLeft,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50,
                  child: GestureDetector(
                    onTap: _pickImage, // Image picker trigger
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 56,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!) as ImageProvider
                            : const AssetImage(
                                'assets/images/user_placeholder.png'),
                        // Placeholder camera replaced with Image asset
                        child: _profileImage == null
                            ? Image.asset('assets/images/camera_icon.png',
                                width: 30)
                            : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),

            // 2. Welcome Message
            RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
                children: [
                  const TextSpan(text: "Hey! "),
                  const TextSpan(
                    text: "Kunal. ",
                    style: TextStyle(
                        color: Color(0xFF01C09A), fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: "Good Morning"),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // 3. Quick Action Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickAction("Orders", "assets/images/bag.png"),
                  _buildQuickAction("My Car", "assets/images/carsp.png"),
                  _buildQuickAction("Wallet", "assets/images/wallet2.png"),
                  _buildQuickAction("Support", "assets/images/support.png"),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 4. Settings Categories
            _buildSettingsGroup("YOUR INFORMATION", [
              _settingsTile("Profile", "assets/images/user 2.png"),
              _settingsTile("Address Book", "assets/images/map-book.png"),
            ]),
            const SizedBox(height: 20),
            _buildSettingsGroup("OTHER INFORMATION", [
              _settingsTile(
                  "Language Selection", "assets/images/language 1.png"),
              _settingsTile(
                  "Notification Preferences", "assets/images/not.png"),
              _settingsTile("About Us", "assets/images/info.png"),
              _settingsTile("Referral", "assets/images/referal.png"),
              _settingsTile("Log out", "assets/images/power-of.png",
                  isLogout: true),
            ]),

            // 5. Dark Mode Toggle

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wb_sunny_outlined,
                      size: 20, color: Colors.grey),
                  Switch(
                    value: false,
                    onChanged: (val) {},
                    activeColor: const Color(0xFF01C09A),
                  ),
                  const Icon(Icons.nightlight_round,
                      size: 20, color: Colors.black),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(String label, String imagePath) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyOrdersScreen(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF01C09A),
              borderRadius: BorderRadius.circular(15),
            ),
            // Icon replaced with Image
            child: Image.asset(imagePath, width: 28, height: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(label,
            style:
                GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildSettingsGroup(String title, List<Widget> tiles) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2)),
          const SizedBox(height: 10),
          ...tiles,
        ],
      ),
    );
  }

  Widget _settingsTile(String label, String imagePath,
      {bool isLogout = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            if (label == "Referral") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ReferralScreen(),
                ),
              );
            } else if (label == "Notification Preferences") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationPreferencesScreen(),
                ),
              );
            } else if (label == "Orders") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MyOrdersScreen(),
                ),
              );
            } else if (label == "Orders") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MyOrdersScreen(),
                ),
              );
            }

            // add more routes here if needed
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            child: Row(
              children: [
                Image.asset(imagePath, width: 22, height: 22),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isLogout ? Colors.red : Colors.black,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
