import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wroom_application/features/auth/pages/brandsearch_screen.dart';
import 'package:wroom_application/features/auth/pages/cartype_screen.dart';

class CarSearchScreen extends StatefulWidget {
  const CarSearchScreen({super.key});

  @override
  State<CarSearchScreen> createState() => _CarSearchScreenState();
}

class _CarSearchScreenState extends State<CarSearchScreen> {
  String selectedFilter = "Range";
  // Added index tracking for the bottom nav
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dynamicAspectRatio = screenWidth > 400 ? 0.75 : 0.68;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Area
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
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
                                builder: (context) => const BrandSearchScreen(),
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
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          "Range",
                          "Speed",
                          "Luxury",
                          "Utility",
                        ].map((label) => _filterChip(label)).toList(),
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Results Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "SEARCH RESULTS",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 32,
                          width: 32,
                          child: Image.asset("assets/images/filter.png"),
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                          height: 32,
                          width: 32,
                          child: Image.asset("assets/images/sort.png"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 3. Responsive Product Grid
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: screenWidth > 600 ? 3 : 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 15,
                  childAspectRatio: dynamicAspectRatio,
                  children: [
                    _buildCarCard(
                      "KIA EV6",
                      "\$45,000",
                      "assets/images/car1.png",
                    ),
                    _buildCarCard(
                      "BENTLY EQ1",
                      "\$990,000",
                      "assets/images/car2.png",
                    ),
                    _buildCarCard(
                      "NISSA EQ Z1",
                      "\$200,000",
                      "assets/images/dash1.png",
                    ),
                    _buildCarCard(
                      "FERRARI EVF1",
                      "\$850,000",
                      "assets/images/car3.png",
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "BRAND",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
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
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildCustomBottomNav(),
    );
  }

  Widget _filterChip(String label) {
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = label),
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 1.2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: GoogleFonts.amiko(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(244, 244, 244, 0.8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, size: 20, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarCard(String name, String price, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(201, 197, 197, 0.04),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color.fromRGBO(255, 219, 99, 1),
          width: 0.5,
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Center(child: Image.asset(imagePath, fit: BoxFit.contain)),
          ),
          const SizedBox(height: 5),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          Row(
            children: List.generate(
              5,
              (index) =>
                  const Icon(Icons.star, color: Color(0xFFE29C40), size: 14),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    price,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  _circleBadge(Icons.percent, const Color(0xFFC00101)),
                  const SizedBox(width: 4),
                  _circleBadge(
                    Icons.favorite_border,
                    Colors.black,
                    isBordered: true,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleBadge(IconData icon, Color color, {bool isBordered = false}) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: isBordered ? Colors.white : color,
        shape: BoxShape.circle,
        border: isBordered ? Border.all(color: Colors.black, width: 0.5) : null,
      ),
      child: Icon(
        icon,
        color: isBordered ? Colors.black : Colors.white,
        size: 10,
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
      onTap: () =>
          setState(() => _selectedIndex = index), // Update state on tap
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

// Utility classes defined outside the State class
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
