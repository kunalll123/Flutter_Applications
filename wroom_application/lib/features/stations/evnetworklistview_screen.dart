import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wroom_application/features/stations/evstationdetails_screen.dart';

class EVNetworkListView extends StatefulWidget {
  const EVNetworkListView({super.key});

  @override
  State<EVNetworkListView> createState() => _EVNetworkListViewState();
}

class _EVNetworkListViewState extends State<EVNetworkListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Section (Search & Filters)
            Padding(
              padding: const EdgeInsets.all(20.0),
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

            // 2. Scrollable List of Stations
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildStationCard(
                    name: "RB ROAD CHARGING STATION",
                    address: "5th Street, LM Road, XYZ City, US, LM501A",
                    distance: "2.5 km",
                    rating: 4,
                  ),
                  _buildStationCard(
                    name: "SUBWAY CHARGING STATION",
                    address: "10th Cross, Spencer Road, ABC City, US, LM509A",
                    distance: "10.5 km",
                    rating: 5,
                  ),
                  _buildStationCard(
                    name: "CHARLES CHARGING STATION",
                    address:
                        "101, VII Street, Simple Road, Sigma City, US, LM503A",
                    distance: "15 km",
                    rating: 4,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "LOAD MORE >>",
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                builder: (context) => const EVStationDetailsScreen(),
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
    return Row(
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
                : [const BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Text(f,
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        );
      }).toList(),
    );
  }

  Widget _buildPublicPrivateToggle() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black12)),
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
        _actionIcon(Icons.map_outlined),
      ],
    );
  }

  Widget _toggleBtn(String label, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        color: active ? const Color(0xFFFFDB63) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _actionIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black12)),
      child: Icon(icon, size: 18),
    );
  }

  Widget _buildStationCard(
      {required String name,
      required String address,
      required String distance,
      required int rating}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/station.jpg',
              width: 80,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[200],
                  width: 80,
                  height: 100,
                  child: const Icon(Icons.ev_station)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  style:
                      GoogleFonts.poppins(fontSize: 8, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.wifi, size: 14, color: Colors.grey),
                    const SizedBox(width: 10),
                    const Icon(Icons.local_parking,
                        size: 14, color: Colors.grey),
                    const Spacer(),
                    Text(distance,
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFDB63))),
                  ],
                ),
                const SizedBox(height: 8),
                // FIXED ALIGNMENT: Stars on the left, Badge on the right
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          size: 12,
                          color: index < rating
                              ? const Color(0xFFFFD700)
                              : Colors.grey[300],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF01C09A),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Slots Available",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
