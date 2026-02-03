import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  State<NotificationPreferencesScreen> createState() =>
      _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState
    extends State<NotificationPreferencesScreen> {
  // State for switches
  bool smsUpdates = false;
  bool emailUpdates = true;
  bool whatsappUpdates = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notification preferences",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),

            // Promos and Offers Group
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Promos and Offers",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // SMS Updates
                  _buildPreferenceTile(
                    "assets/images/notifi.png",
                    "Receive SMS updates about coupons, promotions and offers",
                    smsUpdates,
                    (val) => setState(() => smsUpdates = val),
                  ),
                  const Divider(height: 30),

                  // Email Updates
                  _buildPreferenceTile(
                    "assets/images/mail.png",
                    "Receive email updates about coupons, promotions and offers",
                    emailUpdates,
                    (val) => setState(() => emailUpdates = val),
                  ),
                  const Divider(height: 30),

                  // WhatsApp Updates
                  _buildPreferenceTile(
                    "assets/images/wp.png",
                    "Receive WhatsApp updates about coupons, promotions and offers",
                    whatsappUpdates,
                    (val) => setState(() => whatsappUpdates = val),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper to build the preference rows with leading icons ---
  Widget _buildPreferenceTile(String imagePath, String description, bool value,
      Function(bool) onChanged) {
    return Row(
      children: [
        // Leading circular icon container
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: Image.asset(imagePath, width: 20, height: 20),
        ),
        const SizedBox(width: 15),

        // Description text
        Expanded(
          child: Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: Colors.black87,
            ),
          ),
        ),

        // Custom Switch
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF01C09A), // Brand Teal
          activeTrackColor: const Color(0xFF01C09A).withOpacity(0.3),
          inactiveThumbColor: Colors.grey[300],
          inactiveTrackColor: Colors.grey[200],
        ),
      ],
    );
  }
}
