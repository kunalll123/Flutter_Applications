import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EVStationDetailsScreen extends StatelessWidget {
  const EVStationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Scrollable Content Area
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50), // SafeArea spacing

                // Top Search Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildSearchBox(context),
                ),

                const SizedBox(height: 20),

                // Station Image
                _buildHeaderImage(),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Updated Info Card with proper alignment
                      _buildStationInfoCard(),
                      const SizedBox(height: 25),

                      _buildDetailsGrid(),
                      const SizedBox(height: 20),

                      _buildTimingCard(),
                      const SizedBox(height: 120), // Space for fixed button
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. Fixed Bottom Booking Button
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBookingButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBox(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: const Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 10),
                Text("I am looking for", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15),
        const CircleAvatar(
          backgroundColor: Color(0xFFF2F2F2),
          child: Icon(Icons.person_outline, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildHeaderImage() {
    return Center(
      child: Container(
        width: 350,
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.asset('assets/images/station.jpg', fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildStationInfoCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ID: BEOS2023091",
          style: TextStyle(
              color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        // ROW 1: Name, Distance, and Heart
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "RB ROAD CHARGING STATION",
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFFD700), // Yellow title
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text("1.0 Km",
                    style: TextStyle(
                        color: Color(0xFFFFD700),
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                const Icon(Icons.favorite, color: Colors.red, size: 22),
              ],
            ),
          ],
        ),

        // ROW 2: Address and Ratings/Icons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              "5th Street, LM Road\nXYZ City, US, LM509A",
              style: TextStyle(
                  fontSize: 11,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  height: 1.4),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Star Rating
                Row(
                  children: List.generate(
                      5,
                      (index) => Icon(Icons.star,
                          size: 14,
                          color: index < 4
                              ? const Color(0xFFFFD700)
                              : Colors.grey[300])),
                ),
                const SizedBox(height: 8),
                // Utility Icons
                Row(
                  children: [
                    Image.asset(
                      "assets/images/wifi.png",
                      width: 10,
                    ),
                    Image.asset(
                      "assets/images/wifi.png",
                      width: 10,
                    ),
                    Image.asset(
                      "assets/images/wifi.png",
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailsGrid() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _DetailItem(label: "Type 3", subLabel: "Connection"),
          _DetailItem(label: "\$0.5", subLabel: "Per kwh"),
          _DetailItem(label: "\$1.00", subLabel: "Parking Fee"),
        ],
      ),
    );
  }

  Widget _buildTimingCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _TimeColumn(label: "Arrive", time: "Today 09:45"),
          Column(
            children: [
              Text("Duration",
                  style: TextStyle(fontSize: 9, color: Colors.grey)),
              Text("1h 30m",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
            ],
          ),
          _TimeColumn(label: "Depart", time: "Today 11:30"),
        ],
      ),
    );
  }

  Widget _buildBookingButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF01C09A), // Brand Teal
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          child: const Text("BOOK CHARGER",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1)),
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final String label, subLabel;
  const _DetailItem({required this.label, required this.subLabel});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
        const SizedBox(height: 2),
        Text(subLabel,
            style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }
}

class _TimeColumn extends StatelessWidget {
  final String label, time;
  const _TimeColumn({required this.label, required this.time});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(time,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
          ],
        ),
      ],
    );
  }
}
