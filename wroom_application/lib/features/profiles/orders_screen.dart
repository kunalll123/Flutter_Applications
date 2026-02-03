import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wroom_application/features/profiles/referral_screen.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ReferralScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            //
            size: 20,
          ),
        ),
        title: Text(
          "Orders",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset('assets/images/cart.png', width: 28),
          )
        ],
      ),
      body: Column(
        children: [
          // 1. Horizontal Category Filters
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildFilterTab("ALL", isSelected: true),
                _buildFilterTab("ACCESSORIES"),
                _buildFilterTab("VEHICLE BOOKING"),
                _buildFilterTab("CHARGING"),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 2. Orders List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildOrderTile(
                  orderId: "BEOS203981",
                  title: "Alloy Wheels 16 Inches for KIA EV6",
                  status: "Expected Delivery ",
                  date: "20th November",
                  image: "assets/images/tyre2.png",
                ),
                const Divider(),
                _buildOrderTile(
                  orderId: "BEOSC88912",
                  title: "KIA EV6 GT Line - Test Drive",
                  status: "Scheduled on ",
                  date: "18th November",
                  subtitle: "Susheel Motors - Whitefield...",
                  image: "assets/images/car1.png",
                ),
                const Divider(),
                _buildOrderTile(
                  orderId: "BEOS091234",
                  title: "Subway Charging Station",
                  status: "Delivered on ",
                  date: "17th November",
                  subtitle: "Duration : 1hr 30min",
                  image: "assets/images/station.jpg",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- UI Components ---

  Widget _buildFilterTab(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFFDB63) : const Color(0xFF01C09A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.black : Colors.white,
        ),
      ),
    );
  }

  Widget _buildOrderTile({
    required String orderId,
    required String title,
    required String status,
    required String date,
    required String image,
    String? subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(image, width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          // Order Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order ID : $orderId",
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF01C09A),
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                        fontSize: 11, color: const Color(0xFF01C09A)),
                  ),
                RichText(
                  text: TextSpan(
                    style:
                        GoogleFonts.poppins(fontSize: 10, color: Colors.black),
                    children: [
                      TextSpan(text: status),
                      TextSpan(
                        text: date,
                        style: const TextStyle(
                            color: Color(0xFFFFDB63),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Navigation Arrow
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}
