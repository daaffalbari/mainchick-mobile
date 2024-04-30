import 'package:equatable/equatable.dart';

class Prediction extends Equatable {
  const Prediction({
    required this.deases,
    required this.result,
    required this.detail,
  });

  final String deases;
  final String result;
  final String detail;

  @override
  List<Object?> get props => [deases, result, detail];
}
