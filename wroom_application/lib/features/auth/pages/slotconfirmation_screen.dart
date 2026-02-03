import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wroom_application/features/auth/pages/dashboard_page.dart';
import 'package:wroom_application/features/auth/pages/dealer_screen.dart';
import 'package:wroom_application/features/auth/pages/requestcallback_screen.dart';

class SlotConfirmationScreen extends StatelessWidget {
  const SlotConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBDBDBD), // Grey background from SS
      body: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            // 1. MAIN TICKET CARD
            CustomPaint(
              painter: TicketPainter(),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 30,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 30), // Space for the top icon
                    Text(
                      "Congratulations",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: const Color.fromRGBO(44, 45, 48, 1),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Your request is submitted to our Dealer",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    const SizedBox(height: 40),

                    // 2. TICKET DETAILS SECTION
                    _buildTicketDetail("Dealer", "Mark EV Motors"),
                    _buildTicketDetail(
                      "Date and Time",
                      "05 APR, 2024, 10:30 AM",
                    ),
                    _buildTicketDetail("Duration", "1hr 00min"),

                    const SizedBox(height: 30),
                    const Text(
                      "Navigate Me To",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // 3. MAP ICONS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/map2.png', height: 40),
                        const SizedBox(width: 25),
                        Image.asset('assets/images/map3.png', height: 40),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // 4. ACTION BUTTONS
                    Row(
                      children: [
                        Expanded(
                          child: _actionButton(context, "RESCHEDULE",
                              isPrimary: true),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child:
                              _actionButton(context, "CLOSE", isPrimary: true),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 5. TOP FLOATING CHECKMARK ICON
            Positioned(
              top: -35,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RequestCallbackScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(1, 192, 154, 1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFFDB63),
                      width: 4,
                    ),
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 11),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(BuildContext context, String label,
      {bool isPrimary = true}) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DealerScreen(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF01C09A),
        shape: const StadiumBorder(),
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DealerScreen(),
            ),
          );
        },
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}

// --- CUSTOM PAINTER FOR TICKET SHAPE ---
class TicketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    double cutoutRadius = 15.0;
    double cutoutTop = 110.0; // Position of side cutouts

    path.moveTo(0, 20); // Top left corner radius
    path.quadraticBezierTo(0, 0, 20, 0);
    path.lineTo(size.width - 20, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 20);

    // Right side cutout
    path.lineTo(size.width, cutoutTop);
    path.arcToPoint(
      Offset(size.width, cutoutTop + (cutoutRadius * 2)),
      radius: Radius.circular(cutoutRadius),
      clockwise: false,
    );

    path.lineTo(size.width, size.height - 20);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - 20,
      size.height,
    );
    path.lineTo(20, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 20);

    // Left side cutout
    path.lineTo(0, cutoutTop + (cutoutRadius * 2));
    path.arcToPoint(
      Offset(0, cutoutTop),
      radius: Radius.circular(cutoutRadius),
      clockwise: false,
    );

    path.close();
    canvas.drawPath(path, paint);

    // DRAW DASHED LINE
    Paint dashPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    double dashWidth = 5, dashSpace = 3, startX = cutoutRadius;
    while (startX < size.width - cutoutRadius) {
      canvas.drawLine(
        Offset(startX, cutoutTop + cutoutRadius),
        Offset(startX + dashWidth, cutoutTop + cutoutRadius),
        dashPaint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
