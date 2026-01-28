class ProjectModel {
  final int? id;
  final String title;
  final String description;
  final String techStack;
  final String githubUrl;
  final String category;

  ProjectModel({
    this.id,
    required this.title,
    required this.description,
    required this.techStack,
    required this.githubUrl,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'techStack': techStack,
      'githubUrl': githubUrl,
      'category': category, // ✅ Important for filtering
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      techStack: map['techStack'] ?? '',
      githubUrl: map['githubUrl'] ?? '',
      category: map['category'] ?? 'Mobile',
    );
  }
}
