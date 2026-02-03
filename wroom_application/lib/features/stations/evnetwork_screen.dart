import 'dart:ui'
    as ui; // Fixed: Use ui prefix to avoid Path conflict with flutter_map
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wroom_application/features/stations/evnetworklistview_screen.dart';

class EVNetworkScreen extends StatefulWidget {
  const EVNetworkScreen({super.key});

  @override
  State<EVNetworkScreen> createState() => _EVNetworkScreenState();
}

class _EVNetworkScreenState extends State<EVNetworkScreen> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Base Layer: Live OpenStreetMap
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(18.5204, 73.8567),
              initialZoom: 14.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.wroom.application',
              ),
              MarkerLayer(
                markers: [
                  _buildMapMarker(
                      const LatLng(18.5250, 73.8580),
                      "Subway Charging Station",
                      "2.5 km / 5 min",
                      const Color(0xFF01C09A)),
                  _buildMapMarker(
                      const LatLng(18.5150, 73.8500),
                      "Charles charging Station",
                      "10.5 km / 25 min",
                      Colors.orange),
                ],
              ),
            ],
          ),

          // 2. Overlaid Layer: Top Search and Filters inside SafeArea
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  _buildSearchBox(),
                  const SizedBox(height: 15),
                  _buildFilterChips(),
                  const SizedBox(height: 10),
                  _buildPublicPrivateToggle(),
                ],
              ),
            ),
          ),

          // 3. User Current Location Indicator
          Center(
            child: Icon(Icons.navigation,
                color: Colors.blue.withOpacity(0.8), size: 40),
          ),

          // 4. Custom Navigation Bar with Curve
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildCustomBottomNav(),
          ),
        ],
      ),
    );
  }

  // --- UI Components ---

  Widget _buildSearchBox() {
    return Row(
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
                builder: (context) => const EVNetworkListView(),
              ),
            );
          },
          child: CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Image.asset("assets/images/user.png"),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    final filters = ["Nearby", "Recommended", "Recent", "Favorite"];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: filters.map((f) {
          bool isSelected = f == "Nearby";
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFFFDB63) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: isSelected
                  ? null
                  : [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05), blurRadius: 5)
                    ],
            ),
            child: Text(f,
                style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPublicPrivateToggle() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
          child: Row(
            children: [
              _toggleBtn("Public", true),
              _toggleBtn("Private", false),
            ],
          ),
        ),
        const Spacer(),
        _actionIcon(Icons.my_location),
        const SizedBox(width: 10),
        _actionIcon(Icons.tune),
        const SizedBox(width: 10),
        _actionIcon(Icons.list),
      ],
    );
  }

  Widget _toggleBtn(String label, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: active ? const Color(0xFFFFDB63) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style:
              GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _actionIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: Icon(icon, size: 18),
    );
  }

  Marker _buildMapMarker(
      LatLng point, String title, String subtitle, Color color) {
    return Marker(
      point: point,
      width: 200,
      height: 70,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold)),
                Text(subtitle,
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 7)),
              ],
            ),
          ),
          Icon(Icons.location_on, color: color, size: 25),
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

// --- CURVE DRAWING UTILITIES ---

class BottomNavCurveClipper extends CustomClipper<ui.Path> {
  @override
  ui.Path getClip(Size size) {
    ui.Path path = ui.Path();
    double curveHeight = 30.0;
    path.moveTo(0, curveHeight);
    path.quadraticBezierTo(
        size.width / 2, -curveHeight / 2, size.width, curveHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<ui.Path> oldClipper) => false;
}

class BottomNavBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    ui.Paint paint = ui.Paint()
      ..color = Colors.black12
      ..style = ui.PaintingStyle.stroke
      ..strokeWidth = 1.0;
    ui.Path path = ui.Path();
    double curveHeight = 30.0;
    path.moveTo(0, size.height);
    path.lineTo(0, curveHeight);
    path.quadraticBezierTo(
        size.width / 2, -curveHeight / 2, size.width, curveHeight);
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
