class NotificationModel {
  final int id;
  final String title;
  final String body;
  final String type;
  final String data;
  final String userId;
  final String createdBy;
  bool seenStatus;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.data,
    required this.userId,
    required this.createdBy,
    required this.seenStatus,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      type: json['type'],
      data: json['data'],
      userId: json['user_id'],
      createdBy: json['created_by'],
      seenStatus: json['seen_status'] == "1",
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  void toggleSeenStatus() {
    // Make it seen if it's not seen
    if (!seenStatus) {
      seenStatus = true;
    }
  }
}