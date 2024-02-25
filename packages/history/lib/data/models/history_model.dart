import 'package:equatable/equatable.dart';

import '../../domain/entities/history.dart';

class HistoryModel extends Equatable {
  const HistoryModel({
    required this.totalPakan,
    required this.totalPanen,
    required this.date,
    required this.kandangName,
  });

  final int totalPakan;
  final int totalPanen;
  final DateTime date;
  final String kandangName;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        totalPakan: json["total_pakan"],
        totalPanen: json["total_panen"],
        date: DateTime.parse(json["date"]),
        kandangName: json["kandang_name"],
      );

  Map<String, dynamic> toJson() => {
        "total_pakan": totalPakan,
        "total_panen": totalPanen,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "kandang_name": kandangName,
      };

  History toEntity() {
    return History(
      totalPakan: totalPakan,
      totalPanen: totalPanen,
      date: date,
      kandangName: kandangName,
    );
  }

  @override
  List<Object?> get props => [
        totalPakan,
        totalPanen,
        date,
        kandangName,
      ];
}
