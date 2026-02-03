import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({super.key});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
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
        title: Text(
          "Order Summary",
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download_for_offline_outlined,
                color: Color(0xFF01C09A), size: 18),
            label: const Text("Download Invoice",
                style: TextStyle(color: Color(0xFF01C09A), fontSize: 10)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("3 Items in this order",
                style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            const SizedBox(height: 15),

            // 1. Items List with individual trackers
            _buildOrderItem("Alloy Wheels 16 inches for KIA EV6", "\$780.50",
                "\$880.50", "assets/images/tyre2.png", true),
            const SizedBox(height: 15),
            _buildOrderItem("Alloy Wheels 16 inches for KIA EV6", "\$780.50",
                "\$880.50", "assets/images/tyre2.png", false),
            const SizedBox(height: 15),
            _buildOrderItem("Alloy Wheels 16 inches for KIA EV6", "\$780.50",
                "\$880.50", "assets/images/tyre2.png", false),

            const SizedBox(height: 30),
            // 2. Bill Details Section
            const Text("Bill details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            _billRow("MRP", "\$2341.50"),
            _billRow("Product discount", "-\$300.00", isGreen: true),
            _billRow("Item total", "\$2041.50"),
            _billRow("Coupon Code", "-\$250.00", isGreen: true),
            _billRow("Delivery Charges", "Free", isGreen: true),
            const Divider(),
            _billRow("Bill total", "\$1791.50", isBold: true),

            const SizedBox(height: 30),
            // 3. Order Details Section
            const Text("Order details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            _detailText("Order ID", "8335031903", isGrey: true),
            _detailText("Payment", "Paid Online", isGrey: true),
            _detailText(
                "Delivered to", "102, LB St, Calvery, Ontario, Texas, BHA 5042",
                isGrey: true),
            _detailText("Order placed", "15th November 2023, 7:14 PM",
                isGrey: true),

            const SizedBox(height: 30),
            // 4. Help Section
            _buildHelpSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(String title, String price, String oldPrice,
      String img, bool isConfirmed) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(img, width: 50, height: 50),
              const SizedBox(width: 15),
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 12)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(price,
                      style: const TextStyle(
                          color: Color(0xFFFFB300),
                          fontWeight: FontWeight.bold)),
                  Text(oldPrice,
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 10)),
                ],
              )
            ],
          ),
          const SizedBox(height: 15),
          // Progress Tracker
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statusStep("Confirmed", isConfirmed),
              _statusLine(isConfirmed),
              _statusStep("Dispatched", false),
              _statusLine(false),
              _statusStep("Delivered", false),
            ],
          )
        ],
      ),
    );
  }

  Widget _statusStep(String label, bool active) {
    return Column(
      children: [
        CircleAvatar(
            radius: 4,
            backgroundColor:
                active ? const Color(0xFF01C09A) : Colors.grey[300]),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                fontSize: 8, color: active ? Colors.black : Colors.grey)),
      ],
    );
  }

  Widget _statusLine(bool active) {
    return Expanded(
        child: Container(
            height: 1,
            color: active ? const Color(0xFF01C09A) : Colors.grey[300],
            margin: const EdgeInsets.only(bottom: 15)));
  }

  Widget _billRow(String label, String val,
      {bool isGreen = false, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: isBold ? Colors.black : Colors.grey,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(val,
              style: TextStyle(
                  color: isGreen
                      ? const Color(0xFF01C09A)
                      : (isBold ? const Color(0xFFFFB300) : Colors.black),
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _detailText(String label, String value, {bool isGrey = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          Text(value,
              style: TextStyle(
                  fontSize: 10, color: isGrey ? Colors.grey : Colors.black)),
        ],
      ),
    );
  }

  Widget _buildHelpSection() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(15)),
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
                const Text("Need Help?",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                Text("Chat with us about any issue related to your order",
                    style: TextStyle(color: Colors.grey[600], fontSize: 10)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
