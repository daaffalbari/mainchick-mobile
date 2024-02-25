import 'package:core/utils/state_enum.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entities/feed_detail.dart';
import '../../domain/usecases/get_feed_detail.dart';

class FeedDetailNotifier extends ChangeNotifier {
  final GetFeedDetail getFeedDetail;

  FeedDetailNotifier({required this.getFeedDetail});

  RequestState _state = RequestState.empty;

  List<FeedDetail> _feed = [];

  String _message = '';

  RequestState get state => _state;

  List<FeedDetail> get feed => _feed;

  String get message => _message;

  Future<void> fetchFeedDetail(String key) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getFeedDetail.execute(key);

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
      notifyListeners();
    }, (feedData) {
      _feed = feedData;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }
}
