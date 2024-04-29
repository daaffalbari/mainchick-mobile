import 'package:chatbot/domain/entities/prediction.dart';
import 'package:equatable/equatable.dart';

class PredictionModel extends Equatable {
  const PredictionModel({
    required this.deases,
    required this.candidates,
  });

  final String deases;
  final String candidates;

  factory PredictionModel.fromJson(Map<String, dynamic> json) =>
      PredictionModel(
        deases: json["penyakit"],
        candidates: json["candidates"],
      );

  Map<String, dynamic> toJson() => {
        "deases": deases,
        "candidates": candidates,
      };

  Prediction toEntity() {
    return Prediction(
      deases: deases,
      candidates: candidates,
    );
  }

  @override
  List<Object?> get props => [deases, candidates];
}
