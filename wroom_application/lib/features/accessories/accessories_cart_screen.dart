import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wroom_application/features/accessories/accessories_payment_screen.dart';

class AccessoriesCartScreen extends StatefulWidget {
  const AccessoriesCartScreen({super.key});

  @override
  State<AccessoriesCartScreen> createState() => _AccessoriesCartScreenState();
}

class _AccessoriesCartScreenState extends State<AccessoriesCartScreen> {
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
          "Cart",
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Cart Items List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildCartItem(
                    name: "CEAT APTERRA HT",
                    spec: "215/75 R15",
                    price: "\$780.50",
                    image: "assets/images/tyre.jpg",
                    deliveryDate: "25th November",
                  ),
                  const SizedBox(height: 15),
                  _buildCartItem(
                    name: "KIA EV6 Wipers-Pack of 2 (Set)",
                    spec: "215/75 R15",
                    price: "\$80.00",
                    image: "assets/images/wipers.png",
                    deliveryDate: "25th November",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            // 2. Suggestions Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "You may Like this too",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20),
                children: [
                  _buildSuggestionItem("assets/images/aer.jpg"),
                  _buildSuggestionItem("assets/images/aer.jpg"),
                  _buildSuggestionItem("assets/images/aer.jpg"),
                ],
              ),
            ),

            const SizedBox(height: 30),
            // 3. Bill Details
            _buildBillDetails(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      // 4. Sticky Payment Button
      bottomNavigationBar: _buildBottomActionBar(),
    );
  }

  Widget _buildCartItem({
    required String name,
    required String spec,
    required String price,
    required String image,
    required String deliveryDate,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image, width: 60, height: 60, fit: BoxFit.contain),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(spec,
                        style: const TextStyle(
                            color: Color(0xFF01C09A),
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                    const Text("Remove",
                        style: TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
                ),
                Text(name,
                    style: GoogleFonts.poppins(
                        color: Color.fromRGBO(255, 219, 99, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Expected Delivery",
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 8)),
                        Text(deliveryDate,
                            style: const TextStyle(
                                color: Color.fromRGBO(255, 219, 99, 1),
                                fontSize: 10)),
                      ],
                    ),
                    Text(price,
                        style: const TextStyle(
                            color: Color(0xFFFFB300),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                // Quantity Counter
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(Icons.remove, size: 14)),
                        Text("1", style: TextStyle(fontSize: 12)),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(Icons.add, size: 14)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionItem(String image) {
    return Column(
      children: [
        Container(
          width: 100,
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
          ),
          clipBehavior: Clip.antiAlias,
          child: Center(
              child: Image.asset(
            image,
            // width: 60,
            fit: BoxFit.cover,
          )),
        ),
        Text(
          "Godrej Aer-Dashboard car...",
          style: TextStyle(fontSize: 7),
        )
      ],
    );
  }

  Widget _buildBillDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Bill Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 15),
          _billRow("Order Total", "\$860.50"),
          _billRow("Product discount", "-\$110.00", isDiscount: true),
          const Divider(),
          _billRow("Total", "\$750.50", isBold: true),
          const SizedBox(height: 20),
          // Delivery Address Placeholder
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
                          style: TextStyle(color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/images/edit.png', // The large 205/55 R16 illustration
                  height: 24,
                  width: 24,
                  fit: BoxFit.contain,
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
                          style: TextStyle(color: Colors.grey, fontSize: 10)),
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
        ],
      ),
    );
  }

  Widget _billRow(String label, String value,
      {bool isDiscount = false, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: isBold ? Colors.black : Colors.grey,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  color: isDiscount
                      ? const Color(0xFF01C09A)
                      : (isBold ? const Color(0xFFFFB300) : Colors.black),
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
      ]),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AccessoriesPaymentScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(1, 192, 154, 1),
          minimumSize: const Size(double.infinity, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text("PAYMENT",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
