import 'package:flutter/material.dart';
import '../pages/projects_page.dart';

class DesktopDetailsView extends StatelessWidget {
  const DesktopDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        // Responsive breakpoints
        final isMobile = screenWidth < 600;
        final isTablet = screenWidth >= 600 && screenWidth < 1024;

        // Font sizes
        final titleSize =
            isMobile
                ? 28.0
                : isTablet
                ? 36.0
                : 48.0;
        final nameSize =
            isMobile
                ? 20.0
                : isTablet
                ? 28.0
                : 36.0;
        final subtitleSize =
            isMobile
                ? 14.0
                : isTablet
                ? 18.0
                : 22.0;
        final descSize =
            isMobile
                ? 12.0
                : isTablet
                ? 14.0
                : 16.0;

        // Main content widget
        final content = Column(
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Text(
              "Hi !",
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            Text(
              "I'm Akshay Jagtap",
              style: TextStyle(
                fontSize: nameSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Android | Flutter Developer",
              style: TextStyle(
                fontSize: subtitleSize,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),
            const SizedBox(height: 10),
            Text(
              "Flutter developer with 5 years of experience in creating "
              "high-performance, cross-platform apps. Skilled in Dart, state management, "
              "and optimizing mobile experiences.",
              style: TextStyle(fontSize: descSize, color: Colors.white),
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),
            const SizedBox(height: 30),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProjectsPage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  child: const Text(
                    "Explore my work",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );

        // Image widget
        final flutterLogo = Image.network(
          "https://cdn3d.iconscout.com/3d/free/thumb/free-flutter-3d-icon-download-in-png-blend-fbx-gltf-file-formats--android-logo-google-dart-coding-lang-pack-logos-icons-7577998.png?f=webp",
          width: isMobile ? screenWidth * 0.6 : screenWidth * 0.3,
          height: isMobile ? screenWidth * 0.6 : screenWidth * 0.3,
        );

        // Layout switch
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              isMobile
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      content,
                      const SizedBox(height: 20),
                      flutterLogo,
                    ],
                  )
                  : Row(
                    children: [
                      Expanded(child: content),
                      const SizedBox(width: 40),
                      flutterLogo,
                    ],
                  ),
        );
      },
    );
  }
}
