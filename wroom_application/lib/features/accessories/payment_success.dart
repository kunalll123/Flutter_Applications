import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wroom_application/features/accessories/orders_type_screen.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            // 1. Success Illustration Container
            Center(
              child: GestureDetector(
                onTap: () {
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrdersTypeScreen(),
                      ),
                    );
                  };
                },
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFF01C09A), width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // Replace with your success animation or image asset
                  child: const Icon(
                    Icons.check_circle_outline,
                    color: Color(0xFF01C09A),
                    size: 100,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // 2. Success Messages
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrdersTypeScreen(),
                  ),
                );
              },
              child: Text(
                "Order Placed Successfully",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFFB300), // Brand Yellow
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "wow! You earned ",
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey),
                  ),
                  const Icon(Icons.stars, color: Color(0xFFFFB300), size: 18),
                  Text(
                    " 20 Coins on this order",
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
