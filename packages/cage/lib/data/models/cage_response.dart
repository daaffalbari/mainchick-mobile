// class CageResponse extends Equatable {
//   const CageResponse({
//     required this.cageList,
//   });
//
//   final List<CageModel> cageList;
//
//   factory CageResponse.fromJson(Map<String, dynamic> json) => CageResponse(
//         cageList: List<CageModel>.from(
//             json["data"].map((x) => CageModel.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(cageList.map((x) => x.toJson())),
//       };
//
//   @override
//   List<Object?> get props => [cageList];
// }

import 'package:equatable/equatable.dart';

import 'cage_model.dart';

class CageResponse extends Equatable {
  const CageResponse({required this.cageList});

  final List<CageModel> cageList;

  factory CageResponse.fromJson(Map<String, dynamic> json) => CageResponse(
        cageList: json["data"] == null
            ? []
            : List<CageModel>.from(
                json["data"].map((x) => CageModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(cageList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [cageList];
}
