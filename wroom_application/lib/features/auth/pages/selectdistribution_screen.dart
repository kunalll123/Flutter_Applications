import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:wroom_application/features/auth/pages/brandsearch_screen.dart';
import 'package:wroom_application/features/auth/pages/carsearch_screen.dart'
    hide BottomNavBorderPainter, BottomNavCurveClipper;
import 'package:wroom_application/features/auth/pages/dealer_screen.dart'
    hide BottomNavBorderPainter, BottomNavCurveClipper;

class SelectDistributorScreen extends StatefulWidget {
  const SelectDistributorScreen({super.key});

  @override
  State<SelectDistributorScreen> createState() =>
      _SelectDistributorScreenState();
}

class _SelectDistributorScreenState extends State<SelectDistributorScreen> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // DISABLE AUTOMATIC TOP PADDING TO REDUCE HEIGHT
        top: false,
        child: Column(
          children: [
            // 1. COMPACT HEADER (Matches Screenshot 138/141)
            _buildCarHeader(),

            // 2. SCROLLABLE MAP AREA
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        // REPLACE: Static Image replaced with Dynamic OpenStreetMap
                        SizedBox(
                          width: double.infinity,
                          height:
                              500, // Matches your original height for scroll space
                          child: FlutterMap(
                            options: const MapOptions(
                              initialCenter: LatLng(
                                  30.2672, -97.7431), // Texas Coordinates
                              initialZoom: 13.0,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.codestrup.wroom',
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: const LatLng(30.2672, -97.7431),
                                    width: 40,
                                    height: 40,
                                    child: const Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Showroom Card stays positioned over the map
                        Positioned(
                          bottom: 20,
                          left: 20,
                          right: 20,
                          child: _buildShowroomCard(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100), // Ensures scrolling space
                  ],
                ),
              ),
            ),
            // 3. FIXED CUSTOM BOTTOM NAV
            _buildCustomBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildCarHeader() {
    return Container(
      // Reduced top padding and fixed height to keep map visible
      padding: const EdgeInsets.only(top: 45, bottom: 10),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DealerScreen(),
                    ),
                  );
                },
              ),
              const Spacer(),
            ],
          ),
          // Smaller Car View to fit Screenshot 138
          Image.asset(
            "assets/images/carvar1.png",

            height: 200, // Reduced from 400 to show more map
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Text(
            "KIA EV6 GT line AWD",
            style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "PREFERRED SHOWROOM",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShowroomCard() {
    return Container(
      width: 381, // Matches Figma "Hug (381px)"
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2).withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "MARK EV MOTORS",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w900,
                    fontSize: 8,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "5th Cross, Colusa Ave\nTexas, US, TX1 45A",
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    height: 1.2,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(
                  Icons.location_on,
                  color: Color(0xFFFFD700),
                  size: 22,
                ),
                Text(
                  "Get Directions",
                  style: GoogleFonts.inter(
                    fontSize: 6,
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      color: index < 4
                          ? const Color(0xFFFFD700)
                          : Colors.grey.shade400,
                      size: 13,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C569),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 0,
                  ),
                  child: Text(
                    "SELECT SLOTS",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                    ),
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
