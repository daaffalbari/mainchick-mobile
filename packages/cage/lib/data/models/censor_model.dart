import 'package:equatable/equatable.dart';

class CensorModel extends Equatable {
  const CensorModel({
    required this.indorSesor,
    required this.windSensors,
    required this.outdoorSensors,
  });

  final List<IndorSesor> indorSesor;
  final WindSensors windSensors;
  final OutdoorSensors outdoorSensors;

  factory CensorModel.fromJson(Map<String, dynamic> json) => CensorModel(
        indorSesor: List<IndorSesor>.from(
            json["indor_sesor"].map((x) => IndorSesor.fromJson(x))),
        windSensors: WindSensors.fromJson(json["wind_sensors"]),
        outdoorSensors: OutdoorSensors.fromJson(json["outdoor_sensors"]),
      );

  Map<String, dynamic> toJson() => {
        "indor_sesor": List<dynamic>.from(indorSesor.map((x) => x.toJson())),
        "wind_sensors": windSensors.toJson(),
        "outdoor_sensors": outdoorSensors.toJson(),
      };

  @override
  List<Object?> get props => [
        indorSesor,
        windSensors,
        outdoorSensors,
      ];
}

class IndorSesor {
  IndorSesor({
    required this.temperature,
    required this.humidity,
    required this.a,
    required this.b,
    required this.idKandang,
    required this.lantai,
    required this.posisi,
    required this.tanggal,
    required this.tipe,
    required this.urutan,
    required this.waktu,
    required this.key,
  });

  final String temperature;
  final String humidity;
  final String a;
  final String b;
  final int idKandang;
  final int lantai;
  final String posisi;
  final DateTime tanggal;
  final String tipe;
  final int urutan;
  final String waktu;
  final String key;

  factory IndorSesor.fromJson(Map<String, dynamic> json) => IndorSesor(
        temperature: json["temperature"],
        humidity: json["humidity"],
        a: json["a"],
        b: json["b"],
        idKandang: json["id_kandang"],
        lantai: json["lantai"],
        posisi: json["posisi"],
        tanggal: DateTime.parse(json["tanggal"]),
        tipe: json["tipe"],
        urutan: json["urutan"],
        waktu: json["waktu"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "temperature": temperature,
        "humidity": humidity,
        "a": a,
        "b": b,
        "id_kandang": idKandang,
        "lantai": lantai,
        "posisi": posisi,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "tipe": tipe,
        "urutan": urutan,
        "waktu": waktu,
        "key": key,
      };
}

class WindSensors {
  WindSensors({
    required this.temperature,
    required this.humidity,
    required this.a,
    required this.b,
    required this.lantai,
    required this.tanggal,
    required this.tipe,
    required this.urutan,
    required this.waktu,
    required this.key,
  });

  final String temperature;
  final String humidity;
  final String a;
  final String b;
  final int lantai;
  final DateTime tanggal;
  final String tipe;
  final int urutan;
  final String waktu;
  final String key;

  factory WindSensors.fromJson(Map<String, dynamic> json) => WindSensors(
        temperature: json["temperature"],
        humidity: json["humidity"],
        a: json["a"],
        b: json["b"],
        lantai: json["lantai"],
        tanggal: DateTime.parse(json["tanggal"]),
        tipe: json["tipe"],
        urutan: json["urutan"],
        waktu: json["waktu"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "temperature": temperature,
        "humidity": humidity,
        "a": a,
        "b": b,
        "lantai": lantai,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "tipe": tipe,
        "urutan": urutan,
        "waktu": waktu,
        "key": key,
      };
}

class OutdoorSensors {
  OutdoorSensors({
    required this.temperature,
    required this.humidity,
    required this.idKandang,
    required this.lantai,
    required this.posisi,
    required this.tanggal,
    required this.tipe,
    required this.urutan,
    required this.waktu,
    required this.key,
  });

  final String temperature;
  final String humidity;
  final int idKandang;
  final int lantai;
  final String posisi;
  final DateTime tanggal;
  final String tipe;
  final int urutan;
  final String waktu;
  final String key;

  factory OutdoorSensors.fromJson(Map<String, dynamic> json) => OutdoorSensors(
        temperature: json["temperature"],
        humidity: json["humidity"],
        idKandang: json["id_kandang"],
        lantai: json["lantai"],
        posisi: json["posisi"],
        tanggal: DateTime.parse(json["tanggal"]),
        tipe: json["tipe"],
        urutan: json["urutan"],
        waktu: json["waktu"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "temperature": temperature,
        "humidity": humidity,
        "id_kandang": idKandang,
        "lantai": lantai,
        "posisi": posisi,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "tipe": tipe,
        "urutan": urutan,
        "waktu": waktu,
        "key": key,
      };
}
