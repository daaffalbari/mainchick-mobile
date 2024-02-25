import 'prediction.dart';

class UploadResponse {
  UploadResponse({
    required this.id,
    required this.project,
    required this.iteration,
    required this.created,
    required this.predictions,
  });

  String id;
  String project;
  String iteration;
  DateTime created;
  List<Prediction> predictions;

  factory UploadResponse.fromJson(Map<String, dynamic> json) => UploadResponse(
        id: json["id"],
        project: json["project"],
        iteration: json["iteration"],
        created: DateTime.parse(json["created"]),
        predictions: List<Prediction>.from(
            json["predictions"].map((x) => Prediction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project": project,
        "iteration": iteration,
        "created": created.toIso8601String(),
        "predictions": List<dynamic>.from(predictions.map((x) => x.toJson())),
      };
}
