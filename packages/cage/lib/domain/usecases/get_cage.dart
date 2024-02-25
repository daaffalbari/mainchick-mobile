import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/cage.dart';
import '../repositories/cage_repository.dart';

class GetCage {
  final CageRepository repository;

  GetCage(this.repository);

  Future<Either<Failure, List<Cage>>> execute() {
    return repository.getCage();
  }
}
