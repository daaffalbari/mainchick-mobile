import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/chart.dart';
import '../repositories/cage_repository.dart';

class GetChart {
  final CageRepository repository;

  GetChart(this.repository);

  Future<Either<Failure, List<Chart>>> execute(String key) {
    return repository.getChart(key);
  }
}
