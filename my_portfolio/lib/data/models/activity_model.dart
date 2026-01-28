class ActivityModel {
  final String? id;
  final String content;
  final String date;

  ActivityModel({this.id, required this.content, required this.date});

  Map<String, dynamic> toMap() {
    return {'id': id, 'content': content, 'date': date};
  }

  factory ActivityModel.fromMap(Map<String, dynamic> map, String docId) {
    return ActivityModel(id: docId, content: map['content'], date: map['date']);
  }
}
