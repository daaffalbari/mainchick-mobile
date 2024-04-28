import 'package:equatable/equatable.dart';

enum TypeNotification {
  temperature,
  humidity,
  ammonia,
  chicken,
}

class Notification extends Equatable {
  const Notification({
    required this.type,
    required this.title,
    required this.description,
    required this.createdAt,
    this.isRead = false,
  });

  final TypeNotification type;
  final String title;
  final String description;
  final DateTime createdAt;
  final bool isRead;

  @override
  List<Object?> get props => [
        type,
        title,
        description,
        isRead,
        createdAt,
      ];
}
