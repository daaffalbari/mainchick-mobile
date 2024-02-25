import 'package:equatable/equatable.dart';

import 'chart_model.dart';

class ChartResponse extends Equatable {
  const ChartResponse({
    required this.chartList,
  });

  final List<ChartModel> chartList;

  factory ChartResponse.fromJson(Map<String, dynamic> json) => ChartResponse(
        chartList: List<ChartModel>.from(
            json["data"].map((x) => ChartModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(chartList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [chartList];
}
