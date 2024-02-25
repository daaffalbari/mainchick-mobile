import 'package:equatable/equatable.dart';

class Feed extends Equatable {
  const Feed({
    required this.kandangName,
    required this.status,
  });

  final String kandangName;
  final bool status;

  @override
  List<Object?> get props => [
        kandangName,
        status,
      ];
}
