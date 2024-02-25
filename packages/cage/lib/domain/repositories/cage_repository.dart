import 'package:cage/domain/entities/cage_block.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/cage.dart';
import '../entities/censor.dart';
import '../entities/chart.dart';

abstract class CageRepository {
  Future<Either<Failure, List<Cage>>> getCage();

  Future<Either<Failure, Censor>> getCensor();

  Future<Either<Failure, List<Chart>>> getChart(String key);

  Future<Either<Failure, List<CageBlock>>> getCageBlock(String key);
}
