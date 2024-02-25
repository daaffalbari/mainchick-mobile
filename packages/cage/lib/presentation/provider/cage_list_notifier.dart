import 'package:core/utils/state_enum.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entities/cage.dart';
import '../../domain/usecases/get_cage.dart';

class CageListNotifier extends ChangeNotifier {
  final GetCage getCage;

  CageListNotifier({required this.getCage});

  RequestState _state = RequestState.empty;

  List<Cage> _cage = [];

  String _message = '';

  RequestState get state => _state;

  List<Cage> get cage => _cage;

  String get message => _message;

  Future<void> fetchCage() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getCage.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
      notifyListeners();
    }, (cageData) {
      _cage = cageData;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }
}
