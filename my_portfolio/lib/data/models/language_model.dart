class LanguageModel {
  final int? id;
  final String name;
  final String proficiency; // e.g., Native, Professional, Elementary

  LanguageModel({this.id, required this.name, required this.proficiency});

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'proficiency': proficiency,
  };

  factory LanguageModel.fromMap(Map<String, dynamic> map) => LanguageModel(
    id: map['id'],
    name: map['name'],
    proficiency: map['proficiency'],
  );
}
