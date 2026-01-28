import 'package:flutter/material.dart';
import '../pages/projects_page.dart';

class MobileDetailsView extends StatelessWidget {
  const MobileDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Hi !",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.09,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        Text(
          "I'm Akshay Jagtap",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.07,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          "Android | Flutter Developer",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Flutter developer with 5 years of experience in creating "
          "high-performance, cross-platform apps. Skilled in Dart, state management, "
          "and optimizing mobile experiences.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.03,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 40),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProjectsPage()),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              "Explore my work",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.03,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),

        /// Flutter Logo
        Image.network(
          "https://cdn3d.iconscout.com/3d/free/thumb/free-flutter-3d-icon-download-in-png-blend-fbx-gltf-file-formats--android-logo-google-dart-coding-lang-pack-logos-icons-7577998.png?f=webp",
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
        ),
      ],
    );
  }
}
