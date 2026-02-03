import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wroom_application/features/accessories/tyres_screen.dart';

class AccessoriesDashboard extends StatefulWidget {
  const AccessoriesDashboard({super.key});

  @override
  State<AccessoriesDashboard> createState() => _AccessoriesDashboardState();
}

class _AccessoriesDashboardState extends State<AccessoriesDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/images/loc.png",
                    width: 22,
                    height: 22,
                  ),
                ),
              ),
              // Text("Location",
              //     style:
              //         GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),

              Column(
                children: [
                  Text("Location",
                      style: GoogleFonts.poppins(
                          color: Colors.grey, fontSize: 12)),
                  Text("Texas",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ]),
        actions: [
          // ❤️ Favorite Image
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              "assets/images/heart.png",
              width: 22,
              height: 22,
            ),
          ),

          // 🛍 Shopping Bag Image
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              "assets/images/cart.png",
              width: 22,
              height: 22,
            ),
          ),

          // 👤 Profile Image Avatar
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage("assets/images/user.png"),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Search Bar
            SearchBar(
              hintText: "I am looking for",
              elevation: WidgetStateProperty.all(0),
              backgroundColor: WidgetStateProperty.all(Colors.grey[100]),
            ),
            const SizedBox(height: 25),

            // 2. Limited Offer Banner
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage(
                      'assets/images/design.png'), // Export from Figma
                  fit: BoxFit.cover,
                ),
              ),
              clipBehavior: Clip.antiAlias,
            ),
            const SizedBox(height: 30),

            // 3. Categories Section
            Text("Categories",
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              children: [
                _buildCategoryItem("Battery", "assets/images/inverter.png"),
                _buildCategoryItem("Brakes", "assets/images/brakes.png"),
                _buildCategoryItem("Tyres", "assets/images/tyres.png"),
                _buildCategoryItem("Lights", "assets/images/lights.png"),
                _buildCategoryItem("Side Mirror", "assets/images/mirror.png"),
                _buildCategoryItem(
                    "Suspension", "assets/images/suspension.png"),
                _buildCategoryItem(
                    "Body Parts", "assets/images/body_parts.png"),
                _buildCategoryItem("Clutch", "assets/images/steering.png"),
              ],
            ),

            const SizedBox(height: 30),
            // 4. Curated For You
            Text("Curated for You",
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _curatedPlaceholder(),
                  const SizedBox(width: 15),
                  _curatedPlaceholder(),
                  _curatedPlaceholder(),
                  const SizedBox(width: 15),
                  _curatedPlaceholder(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String label, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TyresScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[50],
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(25)),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                height: 60,
                width: 60,
              ),
            ),
            const SizedBox(height: 8),
            Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 10, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _curatedPlaceholder() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
