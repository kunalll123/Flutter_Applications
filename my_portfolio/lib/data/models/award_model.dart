class AwardModel {
  final int? id;
  final String title;
  final String issuer;
  final String date;

  AwardModel({
    this.id,
    required this.title,
    required this.issuer,
    required this.date,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'issuer': issuer,
    'date': date,
  };

  factory AwardModel.fromMap(Map<String, dynamic> map) => AwardModel(
    id: map['id'],
    title: map['title'],
    issuer: map['issuer'],
    date: map['date'],
  );
}
