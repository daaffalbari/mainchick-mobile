import 'package:equatable/equatable.dart';

class Cage extends Equatable {
  const Cage({
    required this.fcr,
    required this.ip,
    required this.namaKandang,
    required this.key,
  });

  final dynamic fcr;
  final dynamic ip;
  final String namaKandang;
  final String key;

  @override
  List<Object?> get props => [
        fcr,
        ip,
        namaKandang,
        key,
      ];
}
