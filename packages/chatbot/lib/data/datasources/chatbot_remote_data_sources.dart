import 'dart:convert';

import 'package:chatbot/data/models/chat_model.dart';
import 'package:chatbot/data/models/chat_response.dart';
import 'package:chatbot/data/models/prediction_model.dart';
import 'package:chatbot/data/models/prediction_response.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// access the API key from the .env file
const apiKey = '7b293993634146b1b5c5cc12b1c43a30';

// final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

abstract class ChatBotRemoteDataSource {
  Future<ChatModel> getChat(String message);
  Future<PredictionModel> postPrediction(List<int> bytes, String fileName);
}

class ChatBotRemoteDataSourceImpl implements ChatBotRemoteDataSource {
  static const baseUrl = 'https://mainchick.et.r.appspot.com/';
  static const chatbot = '$baseUrl/chatbot';
  static const predict = '$baseUrl/predict/check-healthy';

  final http.Client client;

  ChatBotRemoteDataSourceImpl({required this.client});

  @override
  Future<ChatModel> getChat(String message) async {
    final response = await client.post(Uri.parse(chatbot), body: {
      'message': message,
    });
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return ChatResponse.fromJson(json.decode(response.body)).chat;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PredictionModel> postPrediction(
      List<int> bytes, String fileName) async {
    final uri = Uri.parse(predict);
    var request = http.MultipartRequest('POST', uri);

    final multiPartFile = http.MultipartFile.fromBytes(
      "image",
      bytes,
      filename: fileName,
    );
    final Map<String, String> headers = {
      "Content-type": "multipart/form-data",
    };

    request.files.add(multiPartFile);
    request.headers.addAll(headers);

    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;

    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    if (statusCode == 200) {
      debugPrint('Right response $responseData');
      return PredictionResponse.fromJson((json.decode(responseData)))
          .prediction;
    } else {
      debugPrint('False response $responseData');
      throw Exception("Upload file error");
    }
  }
}
