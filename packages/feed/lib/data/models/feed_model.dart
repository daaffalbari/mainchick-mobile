import 'package:equatable/equatable.dart';

import '../../domain/entities/feed.dart';

class FeedModel extends Equatable {
  const FeedModel({
    required this.kandangName,
    required this.status,
  });

  final String kandangName;
  final bool status;

  factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        kandangName: json["kandang_name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "kandang_name": kandangName,
        "status": status,
      };

  Feed toEntity() {
    return Feed(
      kandangName: kandangName,
      status: status,
    );
  }

  @override
  List<Object?> get props => [
        kandangName,
        status,
      ];
}
