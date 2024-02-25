import 'package:cage/domain/usecases/get_censor.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entities/censor.dart';

class CensorNotifier extends ChangeNotifier {
  final GetCensor getCensor;

  CensorNotifier(this.getCensor);

  RequestState _state = RequestState.empty;

  late Censor _censor;

  String _message = '';

  RequestState get state => _state;

  Censor get censor => _censor;

  String get message => _message;

  Future<void> fetchCensor() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getCensor.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
      notifyListeners();
    }, (censorData) {
      _censor = censorData;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }
}
