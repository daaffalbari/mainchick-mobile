class Prediction {
  Prediction({
    required this.probability,
    required this.tagId,
    required this.tagName,
    required this.text,
  });

  double probability;
  String tagId;
  String tagName;
  String text;

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
        probability: json["probability"]?.toDouble(),
        tagId: json["tagId"],
        tagName: json["tagName"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "probability": probability,
        "tagId": tagId,
        "tagName": tagName,
        "text": text,
      };
}
