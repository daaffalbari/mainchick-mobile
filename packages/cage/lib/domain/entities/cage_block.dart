import 'package:equatable/equatable.dart';

class CageBlock extends Equatable {
  const CageBlock({
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

  @override
  List<Object?> get props => [
        amonia,
        berat,
        kelembapan,
        suhu,
        index,
      ];
}
