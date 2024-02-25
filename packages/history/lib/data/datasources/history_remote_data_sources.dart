import 'dart:convert';

import 'package:core/utils/constants.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter/foundation.dart';
import 'package:history/data/models/history_model.dart';
import 'package:http/http.dart' as http;

import '../models/history_response.dart';

abstract class HistoryRemoteDataSource {
  Future<List<HistoryModel>> getHistory();
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  static const history = 'history?month=01&year=2023';

  final http.Client client;

  HistoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<HistoryModel>> getHistory() async {
    final response = await client.get(Uri.parse('$baseUrl/$history'));
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return HistoryResponse.fromJson(json.decode(response.body)).historyList;
    } else {
      throw ServerException();
    }
  }
}
