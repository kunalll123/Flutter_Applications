import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:wroom_application/features/accessories/accessories_screen.dart';
import 'package:wroom_application/features/auth/pages/cartype_screen.dart';
import 'package:wroom_application/features/auth/pages/signin_screen.dart';
import 'package:wroom_application/features/profiles/profile_screen.dart';
import '../../../../core/theme/app_colors.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. STATIC HEADER
            _buildStaticHeader(),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "EXPLORE",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Category Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCategoryItem(
                        icon: Icons.electric_car_outlined,
                        label: "Cars",
                        color: const Color(0xFFFFDB63),
                      ),
                      _buildCategoryItem(
                        icon: Icons.ev_station,
                        label: "Stations",
                        color: const Color(0xFF01C09A),
                      ),
                      _buildCategoryItem(
                        icon: Icons.settings_input_component,
                        label: "Parts",
                        color: const Color(0xFF01C09A),
                      ),
                      _buildCategoryItem(
                        icon: Icons.compare_arrows,
                        label: "Compare",
                        color: const Color(0xFF01C09A),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // 2. STREET MAP SECTION (Pure Flutter Map)
                  _buildStreetMap(screenWidth),

                  const SizedBox(height: 30),
                  Text(
                    "EXPLORE EV CLUB",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // 3. STATIC CLUB SECTION
                  _buildStaticClubSection(),

                  const SizedBox(height: 30),
                  _buildMarchOffersDivider(),
                  const SizedBox(height: 20),
                  _buildDreamsBanner(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- STATIC UI COMPONENTS ---

  Widget _buildStaticHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 250,
          width: double.infinity,
          child: Image.asset("assets/images/dash2.jpg", fit: BoxFit.cover),
        ),
        Positioned(
          top: 120,
          child: Column(
            children: [
              Text(
                "NEW LAUNCH",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                "KIA EV6",
                style: GoogleFonts.quicksand(
                  color: const Color(0xFF757A7F),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 100,
                width: 250,
                child:
                    Image.asset("assets/images/dash1.png", fit: BoxFit.contain),
              ),
            ],
          ),
        ),
        _buildHeaderIcons(),
      ],
    );
  }

  Widget _buildStreetMap(double width) {
    return Container(
      width: width,
      height: 165,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF455A64), width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Stack(
          children: [
            FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(18.5204, 73.8567), // Default: Pune
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.codestrup.wroom',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: const LatLng(18.5204, 73.8567),
                      width: 40,
                      height: 40,
                      child: const Icon(Icons.location_on,
                          color: Colors.red, size: 30),
                    ),
                  ],
                ),
              ],
            ),
            // Static Overlay
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                color: Colors.black.withOpacity(0.53),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "There are 10 Charging Stations nearby",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFFDB63),
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      "Nearest one is just 1 km away",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderIcons() {
    return Positioned(
      top: 40,
      right: 20,
      child: Row(
        children: [
          _iconCircle(Icons.arrow_forward, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CarTypeScreen()));
          }),
          const SizedBox(width: 15),
          _iconCircle(Icons.person_outline, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()));
          }),
        ],
      ),
    );
  }

  Widget _iconCircle(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white.withOpacity(0.9),
        child: Icon(icon, color: Colors.black),
      ),
    );
  }

  Widget _buildCategoryItem(
      {required IconData icon, required String label, required Color color}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AccessoriesDashboard(),
              ),
            );
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.black),
          ),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildStaticClubSection() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 210,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('assets/images/dash6.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFDB63),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text("NEW",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/dash4.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/dash5.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMarchOffersDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.black, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text("MARCH OFFERS",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 16)),
        ),
        const Expanded(child: Divider(color: Colors.black, thickness: 1)),
      ],
    );
  }

  Widget _buildDreamsBanner() {
    return Container(
      width: double.infinity,
      height: 351,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.black),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("TIMMERMAN INDUSTRIES",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12)),
          const SizedBox(height: 10),
          Text(
            "DRIVE YOUR DREAMS",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 40),
          ),
        ],
      ),
    );
  }
}
