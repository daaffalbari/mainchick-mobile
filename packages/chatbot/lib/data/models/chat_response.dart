import 'package:equatable/equatable.dart';

import 'chat_model.dart';

class ChatResponse extends Equatable {
  const ChatResponse({
    required this.chat,
  });

  final ChatModel chat;

  factory ChatResponse.fromJson(Map<String, dynamic> json) => ChatResponse(
        chat: ChatModel.fromJson(json["data"][0]["content"]["parts"][0]),
      );

  Map<String, dynamic> toJson() => {
        "chat": chat.toJson(),
      };

  @override
  List<Object?> get props => [chat];
}
