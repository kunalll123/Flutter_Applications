import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wroom_application/features/accessories/orders_summary_screen.dart';

class OrdersTypeScreen extends StatefulWidget {
  const OrdersTypeScreen({super.key});

  @override
  State<OrdersTypeScreen> createState() => _OrdersTypeScreenState();
}

class _OrdersTypeScreenState extends State<OrdersTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        // Wrap children in a Column to fix the 'undefined children' error
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Promotional Prompt
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.directions_car_outlined,
                        color: Colors.grey),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tell us more about your vehicle",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                          Text(
                              "Your answers will help us enhance your shopping experience",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 10)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF01C09A),
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      child: const Text("Let's Go!",
                          style: TextStyle(color: Colors.white, fontSize: 10)),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // 2. Order Summary Tracker Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5))
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Order Summary",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            Text("Order ID - #8335031903",
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 10)),
                          ],
                        ),
                        const Icon(Icons.shopping_bag_outlined,
                            color: Colors.grey, size: 20),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Item Previews
                    Row(
                      children: [
                        _itemThumb("assets/images/tyre2.png"),
                        const SizedBox(width: 10),
                        _itemThumb("assets/images/wipers.png"),
                        const SizedBox(width: 10),
                        _itemThumb(null), // Empty placeholder
                      ],
                    ),
                    const SizedBox(height: 20),
                    // View Summary Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderSummaryScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF01C09A),
                        minimumSize: const Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text("VIEW ORDER SUMMARY",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // 3. Status Stepper
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatusPoint("Confirmed", true),
                  _buildLine(true),
                  _buildStatusPoint("Dispatched", false),
                  _buildLine(false),
                  _buildStatusPoint("Delivered", false),
                ],
              ),
              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/delivery.png', // The large 205/55 R16 illustration
                      height: 28,
                      width: 28,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Your delivery details",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                          Text("Details of your current order",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/loc.png', // The large 205/55 R16 illustration
                      height: 28,
                      width: 28,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Delivery at Home",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                          Text(
                              "102. LB St. Street, Calvery, Onixo, Texas, BHA 5043",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/calling.png', // The large 205/55 R16 illustration
                      height: 28,
                      width: 28,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Nishaanth, 9515XXXXXX",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 5. Help Section
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/lady.png', // The large 205/55 R16 illustration
                      height: 28,
                      width: 28,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Need Help?",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                          Text(
                              "Chat with us about any issue related to your order",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 10)),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Methods ---

  Widget _itemThumb(String? asset) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: asset != null
          ? Image.asset(asset,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image))
          : null,
    );
  }

  Widget _buildStatusPoint(String label, bool isDone) {
    return Column(
      children: [
        CircleAvatar(
          radius: 5,
          backgroundColor: isDone ? const Color(0xFF01C09A) : Colors.grey[300],
        ),
        const SizedBox(height: 8),
        Text(label,
            style: TextStyle(
                fontSize: 10, color: isDone ? Colors.black : Colors.grey)),
      ],
    );
  }

  Widget _buildLine(bool isDone) {
    return Expanded(
      child: Container(
        height: 2,
        color: isDone ? const Color(0xFF01C09A) : Colors.grey[300],
        margin: const EdgeInsets.only(bottom: 20),
      ),
    );
  }
}
