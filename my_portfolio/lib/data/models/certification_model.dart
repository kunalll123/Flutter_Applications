class CertificationModel {
  final int? id;
  final String title;
  final String issuer;
  final String date;

  CertificationModel({
    this.id,
    required this.title,
    required this.issuer,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'issuer': issuer, 'date': date};
  }

  factory CertificationModel.fromMap(Map<String, dynamic> map) {
    return CertificationModel(
      id: map['id'],
      title: map['title'] ?? '',
      issuer: map['issuer'] ?? '',
      date: map['date'] ?? '',
    );
  }
}
