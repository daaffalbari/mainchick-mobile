import 'dart:io';

import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/feed.dart';
import '../../domain/entities/feed_detail.dart';
import '../../domain/repositories/feed_repository.dart';
import '../datasources/feed_remote_data_sources.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteDataSource remoteDataSource;

  FeedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Feed>>> getFeed() async {
    try {
      final result = await remoteDataSource.getFeed();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<FeedDetail>>> getFeedDetail(String key) async {
    try {
      final result = await remoteDataSource.getFeedDetail(key);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
