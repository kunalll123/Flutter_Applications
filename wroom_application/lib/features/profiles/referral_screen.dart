import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        // FIXED: Using 'child' with a 'Column' to fix the parameter error
        child: Column(
          children: [
            // 1. Influencer Card with Gradient
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFBDBDBD),
                    Color(0xFFE0E0E0),
                    Color(0xFF9E9E9E)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  // 1. Watermark Car Logo (Bottom Right)
                  Positioned(
                    bottom: -20,
                    right: -20,
                    child: Opacity(
                      opacity: 0.3,
                      child: Image.asset(
                        "assets/images/logos.png",
                        width: 180,
                        height: 180,
                      ),
                    ),
                  ),
                  // 2. Main Content Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Star Badge
                          Image.asset(
                            'assets/images/star_badge.png',
                            width: 45,
                          ),
                          // WROOM Logo
                          Image.asset(
                            'assets/images/wroom.png',
                            width: 100,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Influencer",
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Valid till 06 Apr 24",
                        style: GoogleFonts.poppins(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        "Nishaanth B",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // 2. Referral Progress Badge
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05), blurRadius: 10)
                  ],
                ),
                child: Column(
                  children: [
                    // 1. Referral Progress Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // Star icon from your assets
                                Image.asset("assets/images/ylwstar.png",
                                    width: 24),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Text(
                                    "Just 5 more referral within 90 days before you become a Ambassador",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // 2. Custom Progress Bar
                            Stack(
                              children: [
                                Container(
                                  height: 8,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                Container(
                                  height: 8,
                                  width:
                                      200, // Adjust this width to show progress
                                  decoration: BoxDecoration(
                                    color: const Color(
                                        0xFF333333), // Dark grey progress
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // 3. Reset Info and Benefits Button
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "Last reset on 09 Oct 23",
                            style: TextStyle(
                                color: Colors.grey.shade400, fontSize: 10),
                          ),
                          const SizedBox(height: 8),
                          // Current Benefits Button
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Current Benefits",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(Icons.keyboard_arrow_down,
                                    size: 14, color: Colors.grey.shade600),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // 3. Wallet Balance Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/wallet.png', width: 28),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text("Your Wallet Balance as on 21 Nov 2023",
                              style: TextStyle(fontSize: 13)),
                        ),
                        Image.asset('assets/images/2000.png', width: 50),
                        const SizedBox(width: 5),
                        Image.asset('assets/images/gold.png', width: 24),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "By referring you get 100 EV coins and referred person will get 50 EV coins",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xFFFFDB63),
                          ),
                          child: const Text("Refer Now",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // 4. Level Criteria
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("LEVEL CRITERIA",
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  buildLevelCriteriaCard(),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 5. Level Benefits Colorful Table
            _buildLevelBenefitsTable(),

            // 6. FAQs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("FAQS",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  _buildFAQTile("How to redeem my Coins?"),
                  const Divider(thickness: 1, color: Color(0xFFEEEEEE)),
                  _buildFAQTile("How do I level up to Ambassador?"),
                  const Divider(thickness: 1, color: Color(0xFFEEEEEE)),
                  _buildFAQTile("How many referrals can I do in a month?"),
                ],
              ),
            ),
            const SizedBox(height: 40),

            Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  color: Color.fromRGBO(245, 245, 245, 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/confused.png",
                    height: 24,
                    width: 24,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Still have any doubts?",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Mail Us",
                    style: GoogleFonts.poppins(
                        color: Color.fromRGBO(1, 192, 154, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 14),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- HELPER METHODS ---

  Widget _buildLevelBenefitsTable() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("LEVEL BENEFITS",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1.5),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1)
            },
            children: [
              TableRow(children: [
                _buildHeaderCell("Benefits", const Color(0xFFF1FDFB)),
                _buildTierHeader("Partner", "assets/images/ylwstar.png",
                    const Color(0xFFFFF9F0)),
                _buildTierHeader("Influencer", "assets/images/star_badge.png",
                    const Color(0xFFF5F5F5),
                    isCurrent: true),
                _buildTierHeader("Ambassador", "assets/images/ylwstar.png",
                    const Color(0xFFFFFDF0)),
              ]),
              _buildBenefitRow(
                  "Coins as cashback", "assets/images/x.png", "2%", "4%",
                  isFirstIcon: true),
              _buildBenefitRow(
                  "Redeem up to on every order", "5%", "10%", "15%"),
              _buildBenefitRow(
                  "Free Delivery Charges",
                  "assets/images/x.png",
                  "assets/images/green_check.png",
                  "assets/images/green_check.png",
                  allIcons: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFAQTile(String question) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(question,
          style:
              GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
      trailing: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300)),
        child: const Icon(Icons.add, color: Colors.grey, size: 18),
      ),
      children: const [
        Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text("Answer placeholder text.",
                style: TextStyle(fontSize: 13, color: Colors.grey)))
      ],
    );
  }

  Widget _buildHeaderCell(String text, Color color) {
    return Container(
        height: 100,
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: color),
        child: Text(text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)));
  }

  Widget _buildTierHeader(String label, String asset, Color color,
      {bool isCurrent = false}) {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
        height: 100,
        decoration: BoxDecoration(color: color),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(height: 10),
          Image.asset(asset, width: 30),
          const SizedBox(height: 5),
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
        ]),
      ),
      if (isCurrent)
        Positioned(
            top: -8,
            left: 0,
            right: 0,
            child: Center(
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300)),
                    child: const Text("Current",
                        style: TextStyle(
                            fontSize: 8, fontWeight: FontWeight.bold))))),
    ]);
  }

  TableRow _buildBenefitRow(String label, dynamic v1, dynamic v2, dynamic v3,
      {bool isFirstIcon = false, bool allIcons = false}) {
    return TableRow(children: [
      Container(
          height: 70,
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(label,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.w500))),
      _valueCell(v1, isIcon: allIcons || isFirstIcon),
      _valueCell(v2, isIcon: allIcons),
      _valueCell(v3, isIcon: allIcons),
    ]);
  }

  Widget _valueCell(dynamic value, {bool isIcon = false}) {
    return Container(
        height: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade100, width: 0.5)),
        child: isIcon
            ? Image.asset(value, width: 18)
            : Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 12)));
  }

  Widget buildLevelCriteriaCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade300)),
      child: Column(children: [
        Container(
          height: 44,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            Expanded(
                child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: const Text("Upgrade Level",
                        style: TextStyle(fontWeight: FontWeight.bold)))),
            const Expanded(
                child: Center(
                    child: Text("Maintain Level",
                        style: TextStyle(fontWeight: FontWeight.w600)))),
          ]),
        ),
        const SizedBox(height: 18),
        Row(children: [
          _buildCriteriaStep(
              "Level 1", "Partner", "10", "Achieved", Colors.green),
          _buildCriteriaStep("Level 2", "Influencer", "15 / 5", "90 Days",
              const Color(0xFF01C09A),
              isHighlighted: true),
          _buildCriteriaStep(
              "Level 3", "Ambassador", "", "You will become", Colors.grey,
              isLast: true),
        ]),
        const SizedBox(height: 18),
        const Text(
            "Note: If you fail to achieve this before mentioned date/days, your level will get reset automatically",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11)),
      ]),
    );
  }

  Widget _buildCriteriaStep(
      String level, String name, String value, String status, Color color,
      {bool isHighlighted = false, bool isLast = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: isHighlighted
            ? BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10))
            : null,
        child: Column(children: [
          Text(level, style: const TextStyle(fontSize: 10)),
          Text(name,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 5),
          isLast
              ? Image.asset(
                  "assets/images/fire.png",
                  height: 32,
                  width: 32,
                )
              : Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(value,
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 10))),
          Text(status,
              textAlign: TextAlign.center, style: const TextStyle(fontSize: 9)),
        ]),
      ),
    );
  }
}
