import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wroom_application/features/auth/pages/carbrandvarient_screen.dart';
import 'package:wroom_application/features/auth/pages/carsearch_screen.dart';

// 1. Convert to StatefulWidget
class BrandSearchScreen extends StatefulWidget {
  const BrandSearchScreen({super.key});

  @override
  State<BrandSearchScreen> createState() => _BrandSearchScreenState();
}

class _BrandSearchScreenState extends State<BrandSearchScreen> {
  // 2. Define state variables here inside the State class
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Floating Backward Icon
          Positioned(
            top: 45,
            left: 15,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CarBrandVariantsScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 26,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildHeaderLogo(
                        'assets/images/brand1.png',
                        "Experience",
                      ),
                      const SizedBox(width: 20),
                      _buildHeaderLogo(
                        'assets/images/brand2.png',
                        "Movement that inspires",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _buildBrandCarItem("KIA EV6", "assets/images/brand4.png"),
                      _buildBrandCarItem(
                        "KIA SELTOS",
                        "assets/images/brand3.png",
                      ),
                      _buildBrandCarItem(
                        "KIA SONET",
                        "assets/images/brand5.png",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildCustomBottomNav(),
    );
  }

  Widget _buildHeaderLogo(String assetPath, String slogan) {
    return Column(
      children: [
        Image.asset(assetPath, height: 40),
        Text(
          slogan,
          style: GoogleFonts.inter(
            fontSize: 8,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildBrandCarItem(String name, String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CarBrandVariantsScreen(),
                    ),
                  );
                },
                child: Text(
                  "VARIANTS",
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: const Color(0xFF3E3E3E),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              const Icon(Icons.arrow_forward_ios, size: 10),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Center(
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                right: 20,
                bottom: 10,
                child: Container(
                  height: 35,
                  width: 35,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset("assets/images/brand6.png"),
                ),
              ),
            ],
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
        // 3. setState is now available because we are in a State class
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

// 4. Move utility classes OUTSIDE the main widget classes
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
