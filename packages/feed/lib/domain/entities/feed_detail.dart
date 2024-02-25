import 'package:equatable/equatable.dart';

class FeedDetail extends Equatable {
  const FeedDetail({
    required this.ayamMati,
    required this.pakan,
    required this.date,
  });

  final int ayamMati;
  final int pakan;
  final DateTime date;

  @override
  List<Object?> get props => [
        ayamMati,
        pakan,
        date,
      ];
}
