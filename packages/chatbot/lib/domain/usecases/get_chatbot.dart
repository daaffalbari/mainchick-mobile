import 'package:chatbot/domain/entities/chat.dart';
import 'package:chatbot/domain/repositories/chatbot_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetChatBot {
  final ChatBotRepository repository;

  GetChatBot(this.repository);

  Future<Either<Failure, Chat>> execute(String message) {
    return repository.getChat(message);
  }
}
