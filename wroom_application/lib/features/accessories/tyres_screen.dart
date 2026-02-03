import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wroom_application/features/accessories/tyre_detail_screen.dart';

class TyresScreen extends StatefulWidget {
  const TyresScreen({super.key});

  @override
  State<TyresScreen> createState() => _TyresScreenState();
}

class _TyresScreenState extends State<TyresScreen> {
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
          // Image.asset(
          //   'assets/images/search.png', // The large 205/55 R16 illustration
          //   height: 28,
          //   width: 28,
          //   fit: BoxFit.contain,
          // ),
          SizedBox(
            width: 10,
          ),
          Image.asset(
            'assets/images/heart.png', // The large 205/55 R16 illustration
            height: 28,
            width: 28,
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: 10,
          ),
          Image.asset(
            'assets/images/cart.png', // The large 205/55 R16 illustration
            height: 28,
            width: 28,
            fit: BoxFit.contain,
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tyres & Wheel Care",
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // 1. Horizontal Brand Logos
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _brandLogo('assets/images/bridgestone.png'),
                  _brandLogo('assets/images/mrf.png'),
                  _brandLogo('assets/images/apollo.jpg'),
                  _brandLogo('assets/images/ceat.jpg'),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 2. Large Tyre Profile Illustration
            Center(
              child: Image.asset(
                'assets/images/tyre_size.png', // The large 205/55 R16 illustration
                height: 180,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 30),

            // 3. Product List
            _buildTyreCard(
              name: "CEAT APTERRA HT",
              price: "\$780.50",
              oldPrice: "\$880.50",
              image: "assets/images/tyre.jpg",
              desc:
                  "The Alnac offers high-quality driving precision, outstanding control, improved braking and impeccable stability while cornering.",
              status: "ADD TO CART",
              statusColor: const Color(0xFF01C09A),
            ),
            const SizedBox(height: 20),
            _buildTyreCard(
              name: "CEAT APTERRA HT",
              price: "\$780.50",
              oldPrice: "\$880.50",
              image: "assets/images/tyre.jpg",
              desc:
                  "The Alnac offers high-quality driving precision, outstanding control, improved braking and impeccable stability while cornering.",
              status: "OUT OF STOCK",
              statusColor: Colors.grey,
              isOutOfStock: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _brandLogo(String path) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Image.asset(path, width: 60, fit: BoxFit.contain),
    );
  }

  Widget _buildTyreCard({
    required String name,
    required String price,
    required String oldPrice,
    required String image,
    required String desc,
    required String status,
    required Color statusColor,
    bool isOutOfStock = false,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TyreDetailPage(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image, width: 90, height: 90),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Heart
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Image.asset("assets/images/heart.png", width: 18),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(desc,
                      style:
                          GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
                      maxLines: 3),

                  const SizedBox(height: 8),

                  // Size Chip
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F7F3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "215/75R15",
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF01C09A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(oldPrice,
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontSize: 12)),
                          Text(price,
                              style: const TextStyle(
                                  color: Color(0xFFFFB300),
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      if (!isOutOfStock)
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // decrease qty
                                  },
                                  child: const Icon(Icons.remove, size: 18),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "1",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    // increase qty
                                  },
                                  child: const Icon(Icons.add, size: 18),
                                ),
                              ],
                            ))
                      else
                        Text("NOTIFY ME",
                            style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold)),
                    ],
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: statusColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(status),
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
}
