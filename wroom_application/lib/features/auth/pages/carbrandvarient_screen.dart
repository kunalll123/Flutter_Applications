import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wroom_application/features/auth/pages/cardetail_screen.dart';

class CarBrandVariantsScreen extends StatefulWidget {
  const CarBrandVariantsScreen({super.key});

  @override
  State<CarBrandVariantsScreen> createState() => _CarBrandVariantsScreenState();
}

class _CarBrandVariantsScreenState extends State<CarBrandVariantsScreen> {
  // PageController with viewportFraction allows side items to be visible
  PageController _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.7,
  );
  int _currentPage = 1;

  final List<String> carImages = [
    "assets/images/carvar3.png",
    "assets/images/carvar1.png", // Focused car initially
    "assets/images/carvar2.png",
  ];

  @override
  void initState() {
    super.initState();
    // 0.7 fraction makes side cars peek in from left and right
    _pageController = PageController(initialPage: 1, viewportFraction: 0.7);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB41C24), // Red background from SS
      body: Stack(
        children: [
          // Header section
          Positioned(
            top: 45,
            left: 15,
            child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFFB6BAC0),
                  size: 26,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CarDetailScreen(),
                    ),
                  );
                }),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 50),
                _buildHeaderLogoSection(),
                const Spacer(flex: 1),

                // --- SCROLLABLE CAR DISPLAY (NO WHITE CONTAINER) ---
                // --- UPDATED SLIDER SECTION ---
                SizedBox(
                  height: 350,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: carImages.length,
                    onPageChanged: (int page) =>
                        setState(() => _currentPage = page),
                    itemBuilder: (context, index) {
                      // Use AnimatedBuilder to recalculate scale on every scroll frame
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          double value = 1.0;

                          // Only calculate if the controller is attached to the view
                          if (_pageController.position.haveDimensions) {
                            // Difference between current page and this item's index
                            value = _pageController.page! - index;

                            // MATH FOR ZOOM EFFECT:
                            // Center car (value 0) gets scale 1.0
                            // Side cars get smaller (e.g., 0.8) as they move away
                            value = (1 - (value.abs() * 0.2)).clamp(0.0, 1.0);
                          } else {
                            // Default scale before scroll starts
                            value = index == _currentPage ? 1.0 : 0.8;
                          }

                          return Center(
                            child: Transform.scale(
                              scale: value, // THIS CREATES THE "ZOOM" LOOK
                              child: Opacity(
                                opacity: value.clamp(
                                  0.5,
                                  1.0,
                                ), // Fades side cars slightly
                                child: child,
                              ),
                            ),
                          );
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CarDetailScreen(),
                              ),
                            );
                          },
                          child: Image.asset(
                            carImages[index],
                            fit: BoxFit.cover,
                            height: 350,
                            width: 470, // Max size for the zoomed middle car
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  "KIA EV6",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15),
                _buildDotIndicator(),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderLogoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Image.asset('assets/images/greyman.png', height: 40),
            Text(
              "Experience",
              style: GoogleFonts.inter(
                fontSize: 8,
                fontStyle: FontStyle.italic,
                color: const Color(0xFFB6BAC0),
              ),
            ),
          ],
        ),
        const SizedBox(width: 5),
        Column(
          children: [
            Image.asset('assets/images/greykia.png', height: 40),
            Text(
              "Movement that inspires",
              style: GoogleFonts.inter(
                fontSize: 8,
                color: const Color(0xFFB6BAC0),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // Custom logic for the unique dot colors in your SS
            color: index == 0
                ? const Color(0xFFD2D5D8)
                : index == 1
                    ? const Color(0xFF990000)
                    : index == 2
                        ? Colors.black
                        : const Color(0xFF293A6F),
            border: (index == _currentPage)
                ? Border.all(color: Colors.white, width: 4.0)
                : null,
          ),
        );
      }),
    );
  }
}
