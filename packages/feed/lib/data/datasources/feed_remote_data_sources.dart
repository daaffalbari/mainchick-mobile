import 'dart:convert';

import 'package:core/utils/constants.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/feed_detail_model.dart';
import '../models/feed_detail_response.dart';
import '../models/feed_model.dart';
import '../models/feed_response.dart';

abstract class FeedRemoteDataSource {
  Future<List<FeedModel>> getFeed();

  Future<List<FeedDetailModel>> getFeedDetail(String key);
}

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  static const feed = 'feeds?date=';
  static const feedDetail = 'feeds/detail?kandang_key=';
  static const addFeed = 'feeds/add';

  final http.Client client;

  FeedRemoteDataSourceImpl({required this.client});

  @override
  Future<List<FeedModel>> getFeed() async {
    final now = DateTime.now();
    final dateFormat = DateFormat('y-MM-dd');
    final todayDate = dateFormat.format(now);

    final response = await client.get(Uri.parse('$baseUrl/$feed$todayDate'));
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return FeedResponse.fromJson(json.decode(response.body)).feedList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<FeedDetailModel>> getFeedDetail(String key) async {
    final response = await client.get(Uri.parse('$baseUrl/$feedDetail$key'));
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return FeedDetailResponse.fromJson(json.decode(response.body))
          .feedDetailList;
    } else {
      throw ServerException();
    }
  }
}
