import 'dart:io';

import 'package:chatbot/data/datasources/chatbot_remote_data_sources.dart';
import 'package:chatbot/domain/entities/chat.dart';
import 'package:chatbot/domain/entities/prediction.dart';
import 'package:chatbot/domain/repositories/chatbot_repository.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class ChatBotRepositoryImpl implements ChatBotRepository {
  final ChatBotRemoteDataSource remoteDataSource;

  ChatBotRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Chat>> getChat(String message) async {
    try {
      final result = await remoteDataSource.getChat(message);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, Prediction>> postPrediction(
      List<int> bytes, String fileName) async {
    try {
      final result = await remoteDataSource.postPrediction(bytes, fileName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
