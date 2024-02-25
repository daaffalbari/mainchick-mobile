import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/feed.dart';
import '../repositories/feed_repository.dart';

class GetFeed {
  final FeedRepository repository;

  GetFeed(this.repository);

  Future<Either<Failure, List<Feed>>> execute() {
    return repository.getFeed();
  }
}
