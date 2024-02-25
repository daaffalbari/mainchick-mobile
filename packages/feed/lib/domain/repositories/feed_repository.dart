import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/feed.dart';
import '../entities/feed_detail.dart';

abstract class FeedRepository {
  Future<Either<Failure, List<Feed>>> getFeed();

  Future<Either<Failure, List<FeedDetail>>> getFeedDetail(String key);
}
