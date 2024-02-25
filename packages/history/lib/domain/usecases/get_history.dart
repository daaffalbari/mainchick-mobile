import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/history.dart';
import '../repositories/history_repository.dart';

class GetHistory {
  final HistoryRepository repository;

  GetHistory(this.repository);

  Future<Either<Failure, List<History>>> execute() {
    return repository.getHistory();
  }
}
