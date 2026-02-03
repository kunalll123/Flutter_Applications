import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wroom_application/features/accessories/payment_success.dart';

class AccessoriesPaymentScreen extends StatefulWidget {
  const AccessoriesPaymentScreen({super.key});

  @override
  State<AccessoriesPaymentScreen> createState() =>
      _AccessoriesPaymentScreenState();
}

class _AccessoriesPaymentScreenState extends State<AccessoriesPaymentScreen> {
  String? selectedPaymentGroup = "Cards";

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
          "Payment",
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Order Summary
            const Text("Order details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            _buildOrderThumbnail("215/75R15", "CEAT APTERRA HT", "\$780.50",
                "assets/images/tyre.jpg"),
            const SizedBox(height: 10),
            _buildOrderThumbnail("215/75R15", "KIA EV6 Wipers", "\$80.00",
                "assets/images/wipers.png"),

            const SizedBox(height: 25),
            // 2. Coins/Discount Banner
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      const Text("400 EV", style: TextStyle(fontSize: 12)),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'assets/images/gold.png', // The large 205/55 R16 illustration
                        height: 18,
                        width: 18,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      const Text("Coins Applied",
                          style: TextStyle(fontSize: 12)),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'assets/images/ok.png', // The large 205/55 R16 illustration
                        height: 18,
                        width: 18,
                        fit: BoxFit.contain,
                      ),
                      const Spacer(),
                      const Text("-\$100.00",
                          style: TextStyle(
                              color: Color(0xFF01C09A),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Text(
                    "View More Offers",
                    style: TextStyle(
                      color: Color(0xFF01C09A),
                    ),
                  )),
                )
              ],
            ),

            const SizedBox(height: 30),
            // 3. Bill Breakdown
            const Text("Bill details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            _billRow("MRP", "\$860.50"),
            _billRow("Product discount", "-\$110.00", isGreen: true),
            _billRow("Coupon Code", "-\$10.00", isGreen: true),
            _billRow("Delivery Charges", "Free", isGreen: true),
            const Divider(),
            _billRow("Bill Total", "\$740.50", isBold: true),

            const SizedBox(height: 30),
            // 4. Delivery Info
            _buildHomeTile(Icons.location_on_outlined, "Delivery at Home",
                "102. LB St. Street, Calvery, Onixo, Texas, BHA 5043"),

            _buildInfoTile(Icons.call, "Nishanth", "9515*******"),

            const SizedBox(height: 30),
            // 5. Payment Methods
            const Text("Payment",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            _buildPaymentExpansion("Cards", Icons.credit_card, true),
            _buildPaymentExpansion(
                "Wallet", Icons.account_balance_wallet_outlined, false),
            _buildPaymentExpansion("Cash", Icons.money, false),
            _buildPaymentExpansion("GPay", Icons.payment, false),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomPayButton(),
    );
  }

  // Helper for Order Items thumbnails
  Widget _buildOrderThumbnail(
      String spec, String name, String price, String img) {
    return Row(
      children: [
        Image.asset(img, width: 40, height: 40),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(spec,
                  style: const TextStyle(
                      color: Color(0xFF01C09A),
                      fontSize: 10,
                      fontWeight: FontWeight.bold)),
              Text(name,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Expansion tile for payment options
  Widget _buildPaymentExpansion(String title, IconData icon, bool isExpanded) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        initiallyExpanded: isExpanded,
        leading: Icon(icon, color: Colors.grey),
        title: Text(title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.keyboard_arrow_down),
        children: isExpanded ? [_buildCardInputFields()] : [],
      ),
    );
  }

  // Credit Card Form fields
  Widget _buildCardInputFields() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        width: 335,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            // 🔹 Row 1 — Name + MM/YY
            Row(
              children: [
                Expanded(
                  child: _lineField("Card Holder Name"),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _lineField("MM/YY"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 🔹 Row 2 — Card Number + CVV
            Row(
              children: [
                Expanded(
                  child: _lineField("Card Number"),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _lineField("CVV"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _lineField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 1,
          color: Colors.black45,
        ),
      ],
    );
  }

  Widget _billRow(String label, String val,
      {bool isGreen = false, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(color: isBold ? Colors.black : Colors.grey)),
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

  Widget _buildHomeTile(IconData icon, String title, String sub) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF01C09A)),
          const SizedBox(width: 15),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(sub,
                    style: const TextStyle(color: Colors.grey, fontSize: 12))
              ])),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String sub) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF01C09A)),
          const SizedBox(width: 15),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(sub,
                    style: const TextStyle(color: Colors.grey, fontSize: 12))
              ])),
        ],
      ),
    );
  }

  Widget _buildBottomPayButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PaymentSuccessScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF01C09A),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: const Text("PAY NOW",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
