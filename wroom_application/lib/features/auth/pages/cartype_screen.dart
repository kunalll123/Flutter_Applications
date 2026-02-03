import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wroom_application/features/auth/pages/brandsearch_screen.dart';
import 'package:wroom_application/features/auth/pages/carsearch_screen.dart';

class CarTypeScreen extends StatefulWidget {
  const CarTypeScreen({super.key});

  @override
  State<CarTypeScreen> createState() => _CarTypeScreenState();
}

class _CarTypeScreenState extends State<CarTypeScreen> {
  String? selectedType = "Sedan";
  // Index to track which icon is active
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- SEARCH BAR ---
              Row(
                children: [
                  Expanded(
                    child: SearchBar(
                      hintText: "I am looking for",
                      elevation: WidgetStateProperty.all(0),
                      backgroundColor: WidgetStateProperty.all(
                        Colors.grey[100],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CarSearchScreen(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: Image.asset("assets/images/user.png"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // --- I PREFER TO DRIVE ---
              Text(
                "I PREFER TO DRIVE",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),

              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCarTypeItem(
                      "Sedan",
                      "assets/images/sedan.png",
                      const Color(0xFFFFDB63),
                    ),
                    _buildCarTypeItem(
                      "Hatchback",
                      "assets/images/hatchback.png",
                      const Color(0xFF01C09A),
                    ),
                    _buildCarTypeItem(
                      "SUV",
                      "assets/images/suv.png",
                      const Color(0xFF01C09A),
                    ),
                    _buildCarTypeItem(
                      "MUV",
                      "assets/images/muv.png",
                      const Color(0xFF01C09A),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // --- BRAND ---
              Text(
                "BRAND",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),

              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _brandLogo("assets/images/mg.png"),
                    _brandLogo("assets/images/kia.png"),
                    _brandLogo("assets/images/mahindra.png"),
                    _brandLogo("assets/images/tata.png"),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // --- PROMOTIONAL BANNER ---
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/honda.gif"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildCustomBottomNav(),
    );
  }

  // --- INTERNAL HELPER METHODS ---

  Widget _buildCarTypeItem(String label, String imagePath, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: color,
            child: ClipOval(
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                width: 50,
                height: 50,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _brandLogo(String path) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BrandSearchScreen(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 25),
        child: Image.asset(path, height: 45, width: 60, fit: BoxFit.contain),
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
              decoration: const BoxDecoration(color: Colors.white),
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
      onTap: () {
        // Correctly updating the state
        setState(() {
          _selectedIndex = index;
        });
      },
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

// --- GLOBAL UTILITY CLASSES ---

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
      ..color = Colors.black
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
