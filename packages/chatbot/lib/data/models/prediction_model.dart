import 'package:chatbot/domain/entities/prediction.dart';
import 'package:equatable/equatable.dart';

class PredictionModel extends Equatable {
  const PredictionModel({
    required this.deases,
    required this.result,
    required this.detail,
  });

  final String deases;
  final String result;
  final String detail;

  factory PredictionModel.fromJson(Map<String, dynamic> json) =>
      PredictionModel(
        deases: json["penyakit"],
        result: json["candidates"][0]["result"],
        detail: json["candidates"][0]["detail"],
      );

  Map<String, dynamic> toJson() => {
        "deases": deases,
        "result": result,
        "detail": detail,
      };

  Prediction toEntity() {
    return Prediction(
      deases: deases,
      result: result,
      detail: detail,
    );
  }

  @override
  List<Object?> get props => [deases, result, detail];
}
