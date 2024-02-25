import 'package:equatable/equatable.dart';

import 'feed_model.dart';

class FeedResponse extends Equatable {
  const FeedResponse({
    required this.feedList,
  });

  final List<FeedModel> feedList;

  factory FeedResponse.fromJson(Map<String, dynamic> json) => FeedResponse(
        feedList: List<FeedModel>.from(
            json["data"].map((x) => FeedModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(feedList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [feedList];
}
