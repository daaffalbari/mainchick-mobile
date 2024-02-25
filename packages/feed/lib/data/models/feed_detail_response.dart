import 'package:equatable/equatable.dart';

import 'feed_detail_model.dart';

class FeedDetailResponse extends Equatable {
  const FeedDetailResponse({
    required this.feedDetailList,
  });

  final List<FeedDetailModel> feedDetailList;

  factory FeedDetailResponse.fromJson(Map<String, dynamic> json) =>
      FeedDetailResponse(
        feedDetailList: List<FeedDetailModel>.from(
            json["data"].map((x) => FeedDetailModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(feedDetailList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [feedDetailList];
}
