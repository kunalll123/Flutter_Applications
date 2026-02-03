import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestCallbackScreen extends StatelessWidget {
  const RequestCallbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFBDBDBD,
      ), // Grey background from Screenshot 150
      body: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            // 1. MAIN TICKET CARD
            CustomPaint(
              painter: SuccessTicketPainter(),
              child: Container(
                width: 386, // Width from Figma inspector
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 35,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 80,
                    ), // Space for top icon and separator
                    Text(
                      "The call-back request was placed successfully.\nOne of our experts will give you a call shortly.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.black,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // 2. CLOSE BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF01C09A,
                          ), // Mint Green
                          shape: const StadiumBorder(),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                        ),
                        child: Text(
                          "CLOSE",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 3. TOP FLOATING CHECKMARK BADGE
            Positioned(
              top: -45,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(1, 192, 154, 1),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFFFDB63), width: 5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- CUSTOM PAINTER FOR SUCCESS TICKET ---
class SuccessTicketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    Path path = Path();
    double cutoutRadius = 15.0;
    double cutoutTop = 90.0; // Alignment of side cutouts per Screenshot 150

    path.moveTo(0, 25);
    path.quadraticBezierTo(0, 0, 25, 0);
    path.lineTo(size.width - 25, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 25);

    // Right side cutout
    path.lineTo(size.width, cutoutTop);
    path.arcToPoint(
      Offset(size.width, cutoutTop + (cutoutRadius * 2)),
      radius: Radius.circular(cutoutRadius),
      clockwise: false,
    );

    path.lineTo(size.width, size.height - 25);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - 25,
      size.height,
    );
    path.lineTo(25, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 25);

    // Left side cutout
    path.lineTo(0, cutoutTop + (cutoutRadius * 2));
    path.arcToPoint(
      Offset(0, cutoutTop),
      radius: Radius.circular(cutoutRadius),
      clockwise: false,
    );

    path.close();
    canvas.drawPath(path, paint);

    // DRAW DASHED SEPARATOR LINE
    Paint dashPaint =
        Paint()
          ..color = Colors.grey.shade200
          ..strokeWidth = 1.2
          ..style = PaintingStyle.stroke;

    double dashWidth = 6, dashSpace = 4, startX = cutoutRadius;
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
