import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wroom_application/features/stations/evnetwork_screen.dart';

class AddEVVehicleScreen extends StatefulWidget {
  const AddEVVehicleScreen({super.key});

  @override
  State<AddEVVehicleScreen> createState() => _AddEVVehicleScreenState();
}

class _AddEVVehicleScreenState extends State<AddEVVehicleScreen> {
  bool _isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EVNetworkScreen(),
                ),
              );
            }),
        title: Text(
          "ADD EV VEHICLE",
          style: GoogleFonts.poppins(
            color: const Color.fromRGBO(0, 0, 0, 1),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Form Fields
            _buildTextField("Car Maker"),
            _buildTextField("Car Model"),
            _buildTextField("VIN"),
            _buildTextField("Vehicle Registration Number"),
            _buildTextField("Battery Capacity"),

            const SizedBox(height: 25),
            Text(
              "PLUG IN TYPE",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 15),
            // Plug-in Selection Grid
            // _buildPlugInGrid(),

            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Image.asset(
                "assets/images/plugins1.png",
                width: 284,
                height: 38,
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: Image.asset(
                "assets/images/plugins2.png",
                height: 38,
                width: 201,
              ),
            ),

            const SizedBox(height: 30),
            Text(
              "YOUR VEHICLE",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 10),
            // Car Image Placeholder
            Center(
              child: Image.asset(
                'assets/images/carvar3.png', // Ensure this asset exists
                height: 160,
                fit: BoxFit.contain,
              ),
            ),

            Row(
              children: [
                Checkbox(
                  value: _isAccepted,
                  activeColor: const Color(0xFF01C09A),
                  onChanged: (val) => setState(() => _isAccepted = val!),
                ),
                const Expanded(
                  child: Text(
                    "I accept all the requirements that we have provided.",
                    style: TextStyle(
                        fontSize: 8, color: Color.fromRGBO(0, 0, 0, 1)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            // Action Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EVNetworkScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(1, 192, 154, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                child: const Text(
                  "ADD & SEARCH STATIONS",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:
              const TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 14),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

//   Widget _buildPlugInGrid() {
//     // List of plug types to match icons in Figma
//     final plugTypes = [
//       'Type 1',
//       'Type 2',
//       'CCS 1',
//       'CCS 2',
//       'CHAdeMO',
//       'Tesla',
//       'GB/T',
//       'Wall'
//     ];

//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4,
//         mainAxisSpacing: 15,
//         crossAxisSpacing: 15,
//       ),
//       itemCount: 8,
//       itemBuilder: (context, index) {
//         return Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.bolt, color: Colors.grey, size: 24),
//               const SizedBox(height: 4),
//               Text(
//                 plugTypes[index],
//                 style:
//                     const TextStyle(fontSize: 8, fontWeight: FontWeight.w500),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
