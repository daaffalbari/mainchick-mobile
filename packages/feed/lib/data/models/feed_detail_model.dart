import 'package:equatable/equatable.dart';

import '../../domain/entities/feed_detail.dart';

class FeedDetailModel extends Equatable {
  const FeedDetailModel({
    required this.ayamMati,
    required this.pakan,
    required this.date,
  });

  final int ayamMati;
  final int pakan;
  final DateTime date;

  factory FeedDetailModel.fromJson(Map<String, dynamic> json) =>
      FeedDetailModel(
        ayamMati: json["ayamMati"],
        pakan: json["pakan"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "ayamMati": ayamMati,
        "pakan": pakan,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };

  FeedDetail toEntity() {
    return FeedDetail(
      ayamMati: ayamMati,
      pakan: pakan,
      date: date,
    );
  }

  @override
  List<Object?> get props => [
        ayamMati,
        pakan,
        date,
      ];
}
