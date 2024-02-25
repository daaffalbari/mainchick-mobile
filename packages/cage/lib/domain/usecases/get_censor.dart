import 'package:cage/domain/entities/censor.dart';
import 'package:cage/domain/repositories/cage_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetCensor {
  final CageRepository repository;

  GetCensor(this.repository);

  Future<Either<Failure, Censor>> execute() {
    return repository.getCensor();
  }
}
