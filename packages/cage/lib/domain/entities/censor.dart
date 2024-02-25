import 'package:equatable/equatable.dart';

import '../../data/models/censor_model.dart';

class Censor extends Equatable {
  const Censor({
    required this.indorSesor,
    required this.windSensors,
    required this.outdoorSensors,
  });

  final List<IndorSesor> indorSesor;
  final WindSensors windSensors;
  final OutdoorSensors outdoorSensors;

  @override
  List<Object?> get props => [
        indorSesor,
        windSensors,
        outdoorSensors,
      ];
}
