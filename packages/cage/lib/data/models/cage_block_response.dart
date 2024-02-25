import 'package:equatable/equatable.dart';

import 'cage_block_model.dart';

class CageBlockResponse extends Equatable {
  const CageBlockResponse({
    required this.cageBlockList,
  });

  final List<CageBlockModel> cageBlockList;

  factory CageBlockResponse.fromJson(Map<String, dynamic> json) =>
      CageBlockResponse(
        cageBlockList: List<CageBlockModel>.from(
            json["data"].map((x) => CageBlockModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(cageBlockList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [cageBlockList];
}
