import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  Chat({
    required this.text,
    this.isReceive = true,
    this.isLoading = false,
  });

  final String text;
  final bool isReceive;
  final bool isLoading;
  final DateTime createdAt = DateTime.now();

  @override
  List<Object?> get props => [
        text,
        isReceive,
        isLoading,
        createdAt,
      ];
}
