import 'package:cage/domain/usecases/get_chart.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/chart.dart';

class ChartNotifier extends ChangeNotifier {
  final GetChart getChart;

  ChartNotifier({required this.getChart});

  RequestState _state = RequestState.empty;

  List<Chart> _chart = [];

  String _message = '';

  RequestState get state => _state;

  List<Chart> get chart => _chart;

  String get message => _message;

  Future<void> fetchChart(String key) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getChart.execute(key);

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
      notifyListeners();
    }, (chartData) {
      _chart = chartData;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }
}
