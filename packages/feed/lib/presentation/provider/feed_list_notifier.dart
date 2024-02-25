import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/feed.dart';
import '../../domain/usecases/get_feed.dart';

class FeedListNotifier extends ChangeNotifier {
  final GetFeed getFeed;

  FeedListNotifier({required this.getFeed});

  RequestState _state = RequestState.empty;

  List<Feed> _feed = [];

  String _message = '';

  RequestState get state => _state;

  List<Feed> get feed => _feed;

  String get message => _message;

  Future<void> fetchFeed() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getFeed.execute();

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
