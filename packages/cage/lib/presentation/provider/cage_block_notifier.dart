import 'package:cage/domain/entities/cage_block.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';

import '../../domain/usecases/get_cage_block.dart';

class CageBlockNotifier extends ChangeNotifier {
  final GetCageBlock getCageBlock;

  CageBlockNotifier({required this.getCageBlock});

  RequestState _state = RequestState.empty;

  List<CageBlock> _cageBlock = [];

  String _message = '';

  RequestState get state => _state;

  List<CageBlock> get cageBlock => _cageBlock;

  String get message => _message;

  Future<void> fetchCageBlock(String key) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getCageBlock.execute(key);

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
      notifyListeners();
    }, (cageBlockData) {
      _cageBlock = cageBlockData;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }
}
