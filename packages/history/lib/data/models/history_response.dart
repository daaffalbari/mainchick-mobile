import 'package:equatable/equatable.dart';

import 'history_model.dart';

class HistoryResponse extends Equatable {
  const HistoryResponse({
    required this.historyList,
  });

  final List<HistoryModel> historyList;

  factory HistoryResponse.fromJson(Map<String, dynamic> json) =>
      HistoryResponse(
        historyList: List<HistoryModel>.from(
            json["data"].map((x) => HistoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(historyList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [historyList];
}
