class NotificationModel {
  final int notificationId;
  final String targetUserId;
  final int userType;
  final String title;
  final String body;
  final int relatedEntityId;
  final int relatedEntityType;
  bool isRead;
  final String createdAt;
  final int? isApproved;
  final String? customerName;
  final int? customerNo;
  final bool isLoan;

  NotificationModel({
    required this.notificationId,
    required this.targetUserId,
    required this.userType,
    required this.title,
    required this.body,
    required this.relatedEntityId,
    required this.relatedEntityType,
    required this.isRead,
    required this.createdAt,
    this.isApproved,
    this.customerName,
    this.customerNo,
    this.isLoan = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final title = _value(json, 'Title')?.toString() ?? '';
    final body = _value(json, 'Body')?.toString() ?? '';
    final relatedEntityType = _toInt(_value(json, 'RelatedEntitytype'));
    final isLoan = relatedEntityType == 77 || _isLoanText('$title $body');
    return NotificationModel(
      notificationId: _toInt(_value(json, 'NotificationId')),
      targetUserId: _value(json, 'TargetUserId')?.toString() ?? '',
      userType: _toInt(_value(json, 'UserType'), fallback: 1),
      title: _value(json, 'Title')?.toString() ?? '',
      body: _value(json, 'Body')?.toString() ?? '',
      relatedEntityId: _toInt(_value(json, 'RelatedEntityId')),
      relatedEntityType: relatedEntityType,
      isRead: _toBool(_value(json, 'IsRead')),
      createdAt: _value(json, 'CreatedAt')?.toString() ?? '',
      isApproved: _toNullableInt(_value(json, 'IsApproved')),
      customerName: _value(json, 'CustomerName')?.toString(),
      customerNo: _toNullableInt(_value(json, 'CUSTOMERNO')),
      isLoan: isLoan,
    );
  }

  static dynamic _value(Map<String, dynamic> json, String key) {
    for (final entry in json.entries) {
      if (entry.key.toLowerCase() == key.toLowerCase()) return entry.value;
    }
    return null;
  }

  static bool _isLoanText(String value) {
    final text = value.toLowerCase();
    return text.contains('تمويل') || text.contains('finance') || text.contains('loan');
  }

  bool get isCancellation {
    final text = '$title $body'.toLowerCase();
    return relatedEntityType == 40 ||
        text.contains('إلغاء') ||
        text.contains('الغاء') ||
        text.contains('cancel') ||
        text.contains('canceled') ||
        text.contains('cancelled');
  }

  static int _toInt(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? fallback;
  }

  static int? _toNullableInt(dynamic value) {
    if (value == null || value.toString().toLowerCase() == 'null') return null;
    return int.tryParse(value.toString());
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
      'isApproved': isApproved,
      'customerName': customerName,
      'customerNo': customerNo,
      'isLoan': isLoan,
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
