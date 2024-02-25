import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/history.dart';
import '../../domain/usecases/get_history.dart';

class HistoryListNotifier extends ChangeNotifier {
  final GetHistory getHistory;

  HistoryListNotifier({required this.getHistory});

  RequestState _state = RequestState.empty;

  List<History> _history = [];

  String _message = '';

  RequestState get state => _state;

  List<History> get history => _history;

  String get message => _message;

  Future<void> fetchHistory() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getHistory.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
      notifyListeners();
    }, (historyData) {
      _history = historyData;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }
}
