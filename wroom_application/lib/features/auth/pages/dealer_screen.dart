import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wroom_application/features/auth/pages/slotconfirmation_screen.dart';

class DealerScreen extends StatefulWidget {
  const DealerScreen({super.key});

  @override
  State<DealerScreen> createState() => _DealerScreenState();
}

class _DealerScreenState extends State<DealerScreen> {
  int _selectedIndex = 1;
  String _bookingType = "Show Room";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDealerHeader(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          _buildShowroomTitleRow(),
                          const SizedBox(height: 20),
                          // THE UPDATED SECTION FOR ZOOMED CAR AND BADGE
                          _buildCarActionSection(),
                          const SizedBox(height: 30),
                          _buildSlotBookingSection(),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildCustomBottomNav(),
          ],
        ),
      ),
    );
  }

  // --- 1. Header with Ellipses ---
  Widget _buildDealerHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 220,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 200, 1, 0.75),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(110)),
          ),
        ),
        Positioned(
          top: -32,
          left: 255,
          child: Container(
            width: 214,
            height: 214,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(1, 192, 154, 1),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 28, top: 120),
          child: Container(
            width: 300,
            height: 229,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Image.asset('assets/images/dealer1.jpg', fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 50,
          left: 30,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SlotConfirmationScreen(),
                ),
              );
            },
            child: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          ),
        ),
      ],
    );
  }

  // --- 2. Title Row ---
  Widget _buildShowroomTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "MARK EV MOTORS",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            Text(
              "5th Cross, Colusa Ave\nTexas, US, TX1 45A",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Row(
              children: List.generate(
                5,
                (index) =>
                    const Icon(Icons.star, color: Color(0xFFFFD700), size: 14),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                SizedBox(
                  width: 17,
                  height: 19,
                  child: Image.asset("assets/images/location.png"),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 17,
                  height: 19,
                  child: Image.asset("assets/images/calling.png"),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // --- 3. UPDATED ZOOMED CAR AND BADGE UI ---
  Widget _buildCarActionSection() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          children: [
            // THE ZOOMED CAR (Expanded and fitted)
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/carvar1.png',
                    height: 220, // Increased height for zoom effect
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                  // THE PERCENTAGE BADGE
                  Positioned(
                    top: 50,
                    right: 10,
                    child: Image.asset(
                      "assets/images/percent.png", // Replace with your asset name
                      width: 45,
                      height: 45,
                    ),
                  ),
                ],
              ),
            ),
            // THE SIDE BUTTONS
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _sideButton("Request Callback"),
                  _sideButton("Finance"),
                  _sideButton("Online Consulting"),
                  _sideButton("Show Room Visit"),
                  _sideButton("Book Now"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _sideButton(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Container(
        height: 30,
        width: 130, // Uniform width
        decoration: BoxDecoration(
          color: const Color.fromRGBO(1, 192, 154, 1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 8,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  // --- 4. Slot Booking Section ---
  Widget _buildSlotBookingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "SLOT BOOKING",
          style: GoogleFonts.inter(fontWeight: FontWeight.w900, fontSize: 14),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            _radioOption("Show Room"),
            const SizedBox(width: 30),
            _radioOption("Home"),
          ],
        ),
        const SizedBox(height: 25),
        _bookingField("Date", "05 APRIL 2024", "assets/images/date.png"),
        const SizedBox(height: 12),
        _bookingField("Time", "10:30 AM", "assets/images/Tumer_duotone.png"),
        const SizedBox(height: 25),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SlotConfirmationScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(1, 192, 154, 1),
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 0,
                ),
                child: const Text(
                  "CONFIRM SLOT NOW",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: const Color.fromRGBO(1, 192, 154, 1),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
              ),
              child: Row(
                children: [
                  const Text(
                    "NEED HELP",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  Image.asset(
                    "assets/images/Question_duotone.png",
                    width: 24,
                    height: 21,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _radioOption(String value) {
    bool isActive = _bookingType == value;
    return GestureDetector(
      onTap: () => setState(() => _bookingType = value),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF01C09A), width: 2),
                color: isActive ? const Color(0xFF01C09A) : Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _bookingField(String label, String value, String assetPath) {
    return Padding(
      padding: const EdgeInsets.only(left: 60),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Container(
            width: 200,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Image.asset(
                  assetPath,
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 12),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomBottomNav() {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        CustomPaint(
          painter: BottomNavBorderPainter(),
          child: ClipPath(
            clipper: BottomNavCurveClipper(),
            child: Container(
              height: 110,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 25,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _navIcon('assets/images/home1.png', 0),
              _navIcon('assets/images/power 1.png', 1),
              _navIcon('assets/images/notification.png', 2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _navIcon(String assetPath, int index) {
    bool isActive = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFFDB63) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(16),
        child: Image.asset(assetPath, fit: BoxFit.contain),
      ),
    );
  }
}

// Global utility classes outside State class
class BottomNavCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double curveHeight = 30.0;
    path.moveTo(0, curveHeight);
    path.quadraticBezierTo(
      size.width / 2,
      -curveHeight / 2,
      size.width,
      curveHeight,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BottomNavBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black12
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    Path path = Path();
    double curveHeight = 30.0;
    path.moveTo(0, size.height);
    path.lineTo(0, curveHeight);
    path.quadraticBezierTo(
      size.width / 2,
      -curveHeight / 2,
      size.width,
      curveHeight,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
