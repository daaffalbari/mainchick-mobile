import 'package:equatable/equatable.dart';

import '../../domain/entities/chart.dart';

class ChartModel extends Equatable {
  const ChartModel({
    required this.dead,
    required this.feed,
    required this.weight,
    required this.date,
  });

  final DeadFeedWeight dead;
  final DeadFeedWeight feed;
  final DeadFeedWeight weight;
  final DateTime date;

  factory ChartModel.fromJson(Map<String, dynamic> json) => ChartModel(
        dead: DeadFeedWeight.fromJson(json["dead"]),
        feed: DeadFeedWeight.fromJson(json["feed"]),
        weight: DeadFeedWeight.fromJson(json["weight"]),
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "dead": dead.toJson(),
        "feed": feed.toJson(),
        "weight": weight.toJson(),
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };

  Chart toEntity() {
    return Chart(
      dead: dead,
      feed: feed,
      weight: weight,
      date: date,
    );
  }

  @override
  List<Object?> get props => [
        dead,
        feed,
        weight,
        date,
      ];
}

class DeadFeedWeight extends Equatable {
  const DeadFeedWeight({
    required this.data,
    required this.ideal,
  });

  final int data;
  final int ideal;

  factory DeadFeedWeight.fromJson(Map<String, dynamic> json) => DeadFeedWeight(
        data: json["data"],
        ideal: json["ideal"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "ideal": ideal,
      };

  @override
  List<Object?> get props => [
        data,
        ideal,
      ];
}
