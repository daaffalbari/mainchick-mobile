import 'package:chatbot/domain/entities/prediction.dart';
import 'package:chatbot/domain/repositories/chatbot_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class PostPrediction {
  final ChatBotRepository repository;

  PostPrediction(this.repository);

  Future<Either<Failure, Prediction>> execute(
      List<int> bytes, String fileName) {
    return repository.postPrediction(bytes, fileName);
  }
}
