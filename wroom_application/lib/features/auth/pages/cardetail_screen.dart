import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wroom_application/features/auth/pages/selectdistribution_screen.dart';

class CarDetailScreen extends StatelessWidget {
  const CarDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main Scrollable Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HEADER: Big Car Image Section
                _buildHeader(context),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 2. Title and Rating Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildTitleSection()),
                          buildOverallRatingSection(),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // 3. Image Thumbnails Scroll
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildImageThumbnail("assets/images/detail1.jpg"),
                            const SizedBox(width: 10),
                            _buildImageThumbnail("assets/images/detail2.png"),
                            const SizedBox(width: 10),
                            _buildImageThumbnail("assets/images/detail3.png"),
                            const SizedBox(width: 10),
                            _buildImageThumbnail("assets/images/detail4.png"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),

                      // 4. Car Specifications Icons Row
                      _buildCarSpecsRow(),
                      const SizedBox(height: 25),

                      // 5. Variant Selection Section
                      _buildVariantSelector(),
                      const SizedBox(height: 25),

                      // 6. Detail Text
                      Text(
                        "IN DETAIL",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 120,
                      ), // Padding for floating buttons
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Action Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomActions(context),
          ),
        ],
      ),
    );
  }

  // --- Variant Selector Function ---
  Widget _buildVariantSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "VARIENT",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 15),
        const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),

        // Variant List Items
        _variantItem("EV6 GT line", "Automatic, Electric", "\$ 45,980*"),
        const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
        _variantItem("EV6 GT line AWD", "Automatic, Electric", "\$ 48,900*"),
        const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
      ],
    );
  }

  Widget _variantItem(String title, String subtitle, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Side: Name and Type
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          // Right Side: Price and Expand Icon
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    price,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Get On Road Price*",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
                size: 28,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Existing Helper Widgets ---
  Widget _buildCarSpecsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSpecItem("assets/images/weight_icon.png", "4,456lbs", "Weight"),
        _buildSpecItem(
          "assets/images/electric_range.png",
          "418km",
          "Electric range",
        ),
        _buildSpecItem("assets/images/speed_icon.png", "200mph", "Top Speed"),
        _buildSpecItem("assets/images/mph.png", "1.99sec", "0-100mph"),
        _buildSpecItem("assets/images/power_icon.png", "408hp", "Power"),
      ],
    );
  }

  Widget _buildSpecItem(String assetPath, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(assetPath, width: 32, height: 32, fit: BoxFit.contain),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700),
        ),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 8, color: const Color(0xFF8E8E8E)),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            height: 350,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/cardetail1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectDistributorScreen(),
              ),
            ),
          ),
        ),
        Positioned(
          top: 70,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/brand1.png', width: 22),
                  const SizedBox(width: 4),
                  Image.asset('assets/images/kia.png', width: 28),
                ],
              ),
              Text(
                "Experience",
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageThumbnail(String assetPath) {
    return Container(
      width: 95,
      height: 78,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.asset(assetPath, fit: BoxFit.cover),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "KIA EV6",
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Text(
          "\$ 45,000",
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              "On-Road Price in Delhi",
              style: GoogleFonts.inter(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(width: 4),
            Image.asset("assets/images/pencil.png", height: 12),
          ],
        ),
      ],
    );
  }

  Widget buildOverallRatingSection() {
    return SizedBox(
      width: 120,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (i) => Icon(
                Icons.star,
                color: i < 4 ? Colors.orange : Colors.grey[300],
                size: 14,
              ),
            ),
          ),
          const Text(
            'Over all Rating',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildColorDot(const Color(0xFF636553)),
              const SizedBox(width: 4),
              _buildColorDot(const Color(0xFFB41C24), isSelected: true),
              const SizedBox(width: 4),
              _buildColorDot(Colors.black),
              const SizedBox(width: 4),
              _buildColorDot(const Color(0xFFFFB800)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorDot(Color color, {bool isSelected = false}) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: isSelected ? Border.all(color: Colors.grey, width: 3) : null,
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      // Removed horizontal padding so containers touch the screen edges
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFB41C24), // Brand Red
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          // First Button
          Expanded(
            child: _actionContainer(context, "BOOK TEST DRIVE",
                hasRightBorder: true),
          ),
          // Second Button
          Expanded(
              child:
                  _actionContainer(context, "BUY NOW", hasRightBorder: false)),
        ],
      ),
    );
  }

  Widget _actionContainer(BuildContext context, String label,
      {bool hasRightBorder = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SelectDistributorScreen(),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(165, 21, 35, 1),
          border: hasRightBorder
              ? const Border(
                  right: BorderSide(color: Colors.white, width: 1),
                )
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
