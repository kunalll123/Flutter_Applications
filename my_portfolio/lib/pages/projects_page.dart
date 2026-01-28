import 'package:flutter/material.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  final List<Map<String, String>> projects = const [
    {
      "title": "Flex Play",
      "description":
          "A sports turf booking app with real-time slot management.",
      "image": "https://cdn-icons-png.flaticon.com/512/616/616408.png",
    },
    {
      "title": "Furever Friends",
      "description":
          "Pet adoption and rescue system with advanced features like virtual meets and AI-based matching.",
      "image": "https://cdn-icons-png.flaticon.com/512/616/616408.png",
    },
    {
      "title": "Quiz App",
      "description": "Interactive quiz app with custom question sets.",
      "image": "https://cdn-icons-png.flaticon.com/512/992/992651.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("My Projects"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Breakpoints: <600 = mobile, 600-1000 = tablet, >1000 = desktop
          if (constraints.maxWidth < 600) {
            return _buildListView();
          } else {
            int crossAxisCount = constraints.maxWidth > 1000 ? 3 : 2;
            return _buildGridView(crossAxisCount);
          }
        },
      ),
    );
  }

  /// For mobile: ListView (vertical scrolling)
  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.grey[900],
          margin: const EdgeInsets.only(bottom: 20),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Image.network(project["image"]!, width: 80, height: 80),
                const SizedBox(height: 15),
                Text(
                  project["title"]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  project["description"]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// For tablet/desktop: GridView
  Widget _buildGridView(int crossAxisCount) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.grey[900],
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(project["image"]!, width: 60, height: 60),
                const SizedBox(height: 15),
                Text(
                  project["title"]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  project["description"]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
