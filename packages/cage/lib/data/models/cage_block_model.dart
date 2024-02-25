import 'package:cage/domain/entities/cage_block.dart';
import 'package:equatable/equatable.dart';

class CageBlockModel extends Equatable {
  const CageBlockModel({
    required this.amonia,
    required this.berat,
    required this.kelembapan,
    required this.suhu,
    required this.index,
  });

  final int amonia;
  final int berat;
  final int kelembapan;
  final int suhu;
  final int index;

  factory CageBlockModel.fromJson(Map<String, dynamic> json) => CageBlockModel(
        amonia: json["amonia"],
        berat: json["berat"],
        kelembapan: json["kelembapan"],
        suhu: json["suhu"],
        index: json["index"],
      );

  Map<String, dynamic> toJson() => {
        "amonia": amonia,
        "berat": berat,
        "kelembapan": kelembapan,
        "suhu": suhu,
        "index": index,
      };

  CageBlock toEntity() {
    return CageBlock(
      amonia: amonia,
      berat: berat,
      kelembapan: kelembapan,
      suhu: suhu,
      index: index,
    );
  }

  @override
  List<Object?> get props => [
        amonia,
        berat,
        kelembapan,
        suhu,
        index,
      ];
}
