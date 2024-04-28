import 'package:chatbot/domain/entities/chat.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ChatBotRepository {
  Future<Either<Failure, Chat>> getChat(String message);
}
