import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:history/domain/entities/history.dart';

abstract class HistoryRepository {
  Future<Either<Failure, List<History>>> getHistory();
}
