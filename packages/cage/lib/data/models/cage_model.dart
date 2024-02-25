import 'package:equatable/equatable.dart';

import '../../domain/entities/cage.dart';

// class CageModel extends Equatable {
//   const CageModel({
//     required this.fcr,
//     required this.ip,
//     required this.namaKandang,
//     required this.key,
//   });
//
//   final double fcr;
//   final int ip;
//   final String namaKandang;
//   final String key;
//
//   factory CageModel.fromJson(Map<String, dynamic> json) => CageModel(
//         fcr: json["fcr"],
//         ip: json["ip"],
//         namaKandang: json["nama_kandang"],
//         key: json["key"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "fcr": fcr,
//         "ip": ip,
//         "nama_kandang": namaKandang,
//         "key": key,
//       };
//
//   Cage toEntity() {
//     return Cage(
//       fcr: fcr,
//       ip: ip,
//       namaKandang: namaKandang,
//       key: key,
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//         fcr,
//         ip,
//         namaKandang,
//         key,
//       ];
// }

class CageModel extends Equatable {
  const CageModel({
    required this.fcr,
    required this.ip,
    required this.namaKandang,
    required this.key,
  });

  final dynamic fcr;
  final dynamic ip;
  final String namaKandang;
  final String key;

  factory CageModel.fromJson(Map<String, dynamic> json) => CageModel(
        fcr: json["fcr"],
        ip: json["ip"],
        namaKandang: json["nama_kandang"] ?? "Kandang",
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "fcr": fcr,
        "ip": ip,
        "nama_kandang": namaKandang,
        "key": key,
      };

  Cage toEntity() {
    return Cage(
      fcr: fcr,
      ip: ip,
      namaKandang: namaKandang,
      key: key,
    );
  }

  @override
  List<Object?> get props => [
        fcr,
        ip,
        namaKandang,
      ];
}
