import 'dart:convert';

import 'package:cage/data/models/cage_block_model.dart';
import 'package:cage/data/models/censor_model.dart';
import 'package:cage/data/models/chart_response.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/cage_block_response.dart';
import '../models/cage_model.dart';
import '../models/cage_response.dart';
import '../models/censor_response.dart';
import '../models/chart_model.dart';

abstract class CageRemoteDataSource {
  Future<List<CageModel>> getCage();

  Future<List<CageBlockModel>> getCageBlock(String key);

  Future<CensorModel> getCensor(String key);

  Future<List<ChartModel>> getChart(String key);
}

class CageRemoteDataSourceImpl implements CageRemoteDataSource {
  static const dashboard = 'dashboard?month=05&year=2022';
  static const cageBlock = 'dashboard/detail?kandang_key=';
  static const censor = 'dashboard/sensor?kandang_key=';
  static const chart = 'dashboard/get-chickens?to_date=2022-05-30&kandang_key=';

  final http.Client client;

  CageRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CageModel>> getCage() async {
    final response = await client.get(Uri.parse('$baseUrl/$dashboard'));
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return CageResponse.fromJson(json.decode(response.body)).cageList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CageBlockModel>> getCageBlock(String key) async {
    final response = await client
        .get(Uri.parse('$baseUrl/$cageBlock$key&year=2022&month=05'));
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return CageBlockResponse.fromJson(json.decode(response.body))
          .cageBlockList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CensorModel> getCensor(String key) async {
    final response = await client.get(Uri.parse('$baseUrl/$censor$key'));
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return CensorResponse.fromJson(json.decode(response.body)).censorType;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ChartModel>> getChart(String key) async {
    final response = await client.get(Uri.parse('$baseUrl/$chart$key'));
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return ChartResponse.fromJson(json.decode(response.body)).chartList;
    } else {
      throw ServerException();
    }
  }
}
