import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wroom_application/features/accessories/accessories_cart_screen.dart';

class TyreDetailPage extends StatefulWidget {
  const TyreDetailPage({super.key});

  @override
  State<TyreDetailPage> createState() => _TyreDetailPageState();
}

class _TyreDetailPageState extends State<TyreDetailPage> {
  int quantity = 1;

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
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Color(0xFF01C09A))),
          Image.asset(
            'assets/images/heart.png', // The large 205/55 R16 illustration
            height: 28,
            width: 28,
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccessoriesCartScreen(),
                ),
              );
            },
            child: Image.asset(
              'assets/images/cart.png', // The large 205/55 R16 illustration
              height: 28,
              width: 28,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Image.asset(
            'assets/images/user.png', // The large 205/55 R16 illustration
            height: 28,
            width: 28,
            fit: BoxFit.contain,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Product Title & Discount Badge
            Text(
              "CEAT APTERRA HT",
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/tyre.jpg', // Large detailed tyre image
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFDB63),
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(15)),
                    ),
                    child: const Text("18% OFF",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ),
              ],
            ),

            // 2. Price & Info Section
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("APTERRA HT",
                        style: TextStyle(
                            color: Color(0xFFFFB300),
                            fontWeight: FontWeight.bold)),
                    const Text("Tubeless Tyre\n5 years warranty",
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < 4
                              ? Icons.star
                              : Icons.star_border, // 4-star rating example
                          color: const Color(
                              0xFFFFDB63), // Yellow color from Figma
                          size: 16,
                        ),
                      ),
                    ),
                    Text("\$780.50",
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: 14)),
                    Text("\$680.50",
                        style: TextStyle(
                            color: Color(0xFFFFB300),
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ],
                ),
              ],
            ),

            Row(
              children: [
                // ✅ Size Button
                ElevatedButton(
                  onPressed: () {
                    print("Size selected");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE6F7F3),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "215/75R15",
                    style: TextStyle(
                      color: Color(0xFF01C09A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),

                ElevatedButton(
                  onPressed: () {
                    print("Size selected");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE6F7F3),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove,
                            size: 14, color: Colors.black),
                      ),
                      Container(
                        width: 27,
                        height: 19,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          "1",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add,
                            size: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black,
                ),
                children: [
                  const TextSpan(text: "Sold By: "),
                  TextSpan(
                    text: "BKR Traders",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // 3. Brand & Offer Badges
            const SizedBox(height: 20),
            Image.asset('assets/images/traders.png', width: 300),

            // 4. Details & Reviews
            const SizedBox(height: 30),
            const Text("Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            const Text(
              "The Alnac offers high-quality driving precision, outstanding control, improved braking and impeccable stability while cornering.",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 30),
            const Text("Reviews",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            _buildReviewItem(),
          ],
        ),
      ),
      // 5. Sticky Bottom Action Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
          ],
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF01C09A),
            minimumSize: const Size(double.infinity, 50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text("PAYMENT",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildReviewItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
            backgroundImage: AssetImage('assets/images/user_profile.png'),
            radius: 20),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Pratik Mohan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Row(
                children: List.generate(
                    5,
                    (index) => const Icon(Icons.star,
                        color: Color(0xFFFFB300), size: 14)),
              ),
              const SizedBox(height: 5),
              const Text(
                "The Alnac offers high-quality driving precision, outstanding control, improved braking.",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        )
      ],
    );
  }
}
