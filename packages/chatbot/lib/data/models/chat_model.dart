import 'package:chatbot/domain/entities/chat.dart';
import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  const ChatModel({
    required this.text,
  });

  final String text;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };

  Chat toEntity() {
    return Chat(
      text: text,
    );
  }

  @override
  List<Object?> get props => [
        text,
      ];
}
