import 'package:equatable/equatable.dart';

class Prediction extends Equatable {
  const Prediction({
    required this.deases,
    required this.candidates,
  });

  final String deases;
  final String candidates;

  @override
  List<Object?> get props => [deases, candidates];
}
