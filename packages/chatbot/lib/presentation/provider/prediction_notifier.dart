import 'package:image/image.dart' as img;
import 'package:chatbot/domain/entities/prediction.dart';
import 'package:chatbot/domain/usecases/post_prediction.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';

class PredictionNotifier extends ChangeNotifier {
  final PostPrediction postPrediction;

  PredictionNotifier({required this.postPrediction});

  RequestState _state = RequestState.empty;

  Prediction? _prediction;

  String _message = '';

  RequestState get state => _state;

  Prediction? get prediction => _prediction;

  String get message => _message;

  Future<void> uploadPrediction(List<int> bytes, String fileName) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await postPrediction.execute(bytes, fileName);

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
      notifyListeners();
    }, (predictionData) {
      _prediction = predictionData;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }

  Future<List<int>> compressImage(Uint8List bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;

    final img.Image image = img.decodeImage(bytes)!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];

    do {
      ///
      compressQuality -= 10;

      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );

      length = newByte.length;
    } while (length > 1000000);

    return newByte;
  }
}
