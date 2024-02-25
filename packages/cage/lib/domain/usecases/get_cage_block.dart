import 'package:cage/domain/entities/cage_block.dart';
import 'package:cage/domain/repositories/cage_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetCageBlock {
  final CageRepository repository;

  GetCageBlock(this.repository);

  Future<Either<Failure, List<CageBlock>>> execute(String key) {
    return repository.getCageBlock(key);
  }
}
