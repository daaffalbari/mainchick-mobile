import 'dart:io';

import 'package:cage/domain/entities/cage_block.dart';
import 'package:cage/domain/entities/censor.dart';
import 'package:cage/domain/entities/chart.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/cage.dart';
import '../../domain/repositories/cage_repository.dart';
import '../datasources/cage_remote_data_sources.dart';

class CageRepositoryImpl implements CageRepository {
  final CageRemoteDataSource remoteDataSource;

  CageRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Cage>>> getCage() async {
    try {
      final result = await remoteDataSource.getCage();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, Censor>> getCensor() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Chart>>> getChart(String key) async {
    try {
      final result = await remoteDataSource.getChart(key);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<CageBlock>>> getCageBlock(String key) async {
    try {
      final result = await remoteDataSource.getCageBlock(key);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
