class NotificationModel {
  final int notificationId;
  final String targetUserId;
  final int userType;
  final String title;
  final String body;
  final int relatedEntityId;
  final int relatedEntityType;
  final bool isRead;
  final String createdAt;

  const NotificationModel({
    required this.notificationId,
    required this.targetUserId,
    required this.userType,
    required this.title,
    required this.body,
    required this.relatedEntityId,
    required this.relatedEntityType,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: _toInt(_value(json, 'NotificationId')),
      targetUserId: _value(json, 'TargetUserId')?.toString() ?? '',
      userType: _toInt(_value(json, 'UserType'), fallback: 1),
      title: _value(json, 'Title')?.toString() ?? '',
      body: _value(json, 'Body')?.toString() ?? '',
      relatedEntityId: _toInt(_value(json, 'RelatedEntityId')),
      relatedEntityType: _toInt(_value(json, 'RelatedEntitytype')),
      isRead: _toBool(_value(json, 'IsRead')),
      createdAt: _value(json, 'CreatedAt')?.toString() ?? '',
    );
  }

  static dynamic _value(Map<String, dynamic> json, String key) {
    for (final entry in json.entries) {
      if (entry.key.toLowerCase() == key.toLowerCase()) return entry.value;
    }
    return null;
  }

  static int _toInt(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? fallback;
  }

  static bool _toBool(dynamic value) {
    if (value is bool) return value;
    return value?.toString().toLowerCase() == 'true' || value?.toString() == '1';
  }

  /// Convert to map for legacy NotificationsLoaded state (keeps backward compat)
  Map<String, dynamic> toMap() {
    return {
      'id': notificationId.toString(),
      'title': title,
      'body': body,
      'time': createdAt,
      'isRead': isRead,
      'type': _resolveType(relatedEntityType),
      'relatedEntityId': relatedEntityId,
      'relatedEntityType': relatedEntityType,
    };
  }

  String _resolveType(int entityType) {
    switch (entityType) {
      case 40:
        return 'reservation';
      case 10:
        return 'order';
      case 20:
        return 'offer';
      default:
        return 'system';
    }
  }
}
