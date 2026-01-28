class EducationModel {
  final int? id;
  final String degree;
  final String institution;
  final String level;
  final String years; // e.g., "2023 - 2025"

  EducationModel({
    this.id,
    required this.degree,
    required this.institution,
    required this.level,
    required this.years,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'institution': institution,
      'degree': degree,
      'years': years,
      'level': level, // ✅ MUST BE HERE
    };
  }

  factory EducationModel.fromMap(Map<String, dynamic> map) {
    return EducationModel(
      id: map['id'],
      institution: map['institution'],
      degree: map['degree'],
      years: map['years'],
      level: map['level'] ?? 'University', // ✅ MUST BE HERE
    );
  }
}
