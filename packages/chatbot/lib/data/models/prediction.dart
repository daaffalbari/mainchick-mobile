class Prediction {
  Prediction({
    required this.probability,
    required this.tagId,
    required this.tagName,
  });

  double probability;
  String tagId;
  String tagName;

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
        probability: json["probability"]?.toDouble(),
        tagId: json["tagId"],
        tagName: json["tagName"],
      );

  Map<String, dynamic> toJson() => {
        "probability": probability,
        "tagId": tagId,
        "tagName": tagName,
      };
}
