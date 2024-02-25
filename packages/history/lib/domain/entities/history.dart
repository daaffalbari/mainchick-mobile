import 'package:equatable/equatable.dart';

class History extends Equatable {
  const History({
    required this.totalPakan,
    required this.totalPanen,
    required this.date,
    required this.kandangName,
  });

  final int totalPakan;
  final int totalPanen;
  final DateTime date;
  final String kandangName;

  @override
  List<Object?> get props => [
        totalPakan,
        totalPanen,
        date,
        kandangName,
      ];
}
