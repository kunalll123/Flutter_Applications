class SkillModel {
  final int? id;
  final String name;
  final String category;
  final int percentage;

  SkillModel({
    this.id,
    required this.name,
    required this.category,
    required this.percentage,
  });

  // Convert a SkillModel into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'percentage': percentage,
    };
  }

  // Extract a SkillModel from a Map.
  factory SkillModel.fromMap(Map<String, dynamic> map) {
    return SkillModel(
      id: map['id'] as int?,
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      percentage: map['percentage'] ?? 0,
    );
  }

  // Useful for updating specific fields
  SkillModel copyWith({
    int? id,
    String? name,
    String? category,
    int? percentage,
  }) {
    return SkillModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      percentage: percentage ?? this.percentage,
    );
  }
}
