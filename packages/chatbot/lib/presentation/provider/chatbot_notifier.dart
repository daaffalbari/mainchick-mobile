import 'package:chatbot/domain/entities/chat.dart';
import 'package:chatbot/domain/usecases/get_chatbot.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';

class ChatBotNotifier extends ChangeNotifier {
  final GetChatBot getChatbot;

  ChatBotNotifier({required this.getChatbot});

  RequestState _state = RequestState.empty;

  Chat? _chat;

  String _message = '';

  RequestState get state => _state;

  Chat? get chat => _chat;

  String get message => _message;

  Future<void> fetchChatbot(String message) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getChatbot.execute(message);

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
      notifyListeners();
    }, (chatData) {
      _chat = chatData;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }
}
