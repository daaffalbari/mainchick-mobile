import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/feed_detail.dart';
import '../repositories/feed_repository.dart';

class GetFeedDetail {
  final FeedRepository repository;

  GetFeedDetail(this.repository);

  Future<Either<Failure, List<FeedDetail>>> execute(String key) {
    return repository.getFeedDetail(key);
  }
}
