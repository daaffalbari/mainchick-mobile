import 'package:equatable/equatable.dart';

import 'prediction_model.dart';

class PredictionResponse extends Equatable {
  const PredictionResponse({
    required this.prediction,
  });

  final PredictionModel prediction;

  factory PredictionResponse.fromJson(Map<String, dynamic> json) =>
      PredictionResponse(
        prediction: PredictionModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "prediction": prediction.toJson(),
      };

  @override
  List<Object?> get props => [prediction];
}
