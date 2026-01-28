class ExperienceModel {
  final int? id;
  final String role;
  final String company;
  final String duration;
  final String period;
  final List<String> responsibilities;

  ExperienceModel({
    this.id,
    required this.role,
    required this.company,
    required this.duration,
    required this.period,
    required this.responsibilities,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'role': role,
    'company': company,
    'duration': duration,
    'period': period,
    'responsibilities': responsibilities.join(
      '|',
    ), // Convert list to string for DB
  };

  factory ExperienceModel.fromMap(Map<String, dynamic> map) => ExperienceModel(
    id: map['id'],
    role: map['role'],
    company: map['company'],
    duration: map['duration'],
    period: map['period'],
    responsibilities: (map['responsibilities'] as String).split(
      '|',
    ), // Convert string back to list
  );
}
