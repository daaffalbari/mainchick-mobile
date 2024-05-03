import 'package:chatbot/domain/entities/chat.dart';
import 'package:chatbot/domain/entities/prediction.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ChatBotRepository {
  Future<Either<Failure, Chat>> getChat(String message);
  Future<Either<Failure, Prediction>> postPrediction(
      List<int> bytes, String fileName);
}
