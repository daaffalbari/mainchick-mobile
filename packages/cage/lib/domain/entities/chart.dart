import 'package:equatable/equatable.dart';

import '../../data/models/chart_model.dart';

class Chart extends Equatable {
  const Chart({
    required this.dead,
    required this.feed,
    required this.weight,
    required this.date,
  });

  final DeadFeedWeight dead;
  final DeadFeedWeight feed;
  final DeadFeedWeight weight;
  final DateTime date;

  @override
  List<Object?> get props => [
        dead,
        feed,
        weight,
        date,
      ];
}
