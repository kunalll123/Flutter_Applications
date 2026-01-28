import 'package:flutter/material.dart';
import '../widgets/nav_bar_widget.dart';
import 'details_page.dart';
import 'projects_page.dart';
import 'contact_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      /// AppBar (visible on mobile for drawer)
      appBar: AppBar(
        title: const Text("Portfolio"),
        backgroundColor: Colors.orange,
      ),

      /// Drawer (used on mobile via hamburger menu)
      endDrawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ListTile(
              leading: const Icon(Icons.home, color: Colors.orange),
              title: const Text("Home", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LandingPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.work, color: Colors.orange),
              title: const Text(
                "Projects",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProjectsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.mail, color: Colors.orange),
              title: const Text(
                "Contact",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ContactPage()),
                );
              },
            ),
          ],
        ),
      ),

      /// Main Body
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20),
        child: Column(
          children: [
            NavBarWidget(),
            Expanded(child: SingleChildScrollView(child: DetailsPage())),
          ],
        ),
      ),
    );
  }
}
