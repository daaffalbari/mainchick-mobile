import 'package:equatable/equatable.dart';

import 'censor_model.dart';

class CensorResponse extends Equatable {
  const CensorResponse({
    required this.censorType,
  });

  final CensorModel censorType;

  factory CensorResponse.fromJson(Map<String, dynamic> json) => CensorResponse(
        censorType: CensorModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": censorType.toJson(),
      };

  @override
  List<Object?> get props => [censorType];
}
