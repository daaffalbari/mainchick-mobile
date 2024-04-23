import 'dart:convert';

import 'package:chatbot/data/models/chat_model.dart';
import 'package:chatbot/data/models/chat_response.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/upload_response.dart';

// access the API key from the .env file
const apiKey = '7b293993634146b1b5c5cc12b1c43a30';

// final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

abstract class ChatBotRemoteDataSource {
  Future<UploadResponse> uploadImage(List<int> bytes, String fileName);
  Future<ChatModel> getChat(String message);
}

class ChatBotRemoteDataSourceImpl implements ChatBotRemoteDataSource {
  static const chatbot = 'https://mainchick.et.r.appspot.com/chatbot';

  final http.Client client;

  ChatBotRemoteDataSourceImpl({required this.client});

  @override
  Future<UploadResponse> uploadImage(List<int> bytes, String fileName) async {
    const String url =
        "https://chickensoul-prediction.cognitiveservices.azure.com/customvision/v3.0/Prediction/371986f4-cefb-4996-9770-a515333dd109/classify/iterations/Iteration1/image";

    final uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);

    final multiPartFile = http.MultipartFile.fromBytes(
      "image",
      bytes,
      filename: fileName,
    );
    final Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      "Prediction-Key": "7b293993634146b1b5c5cc12b1c43a30"
    };

    request.files.add(multiPartFile);
    request.headers.addAll(headers);

    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;

    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    if (statusCode == 200) {
      debugPrint('Right response $responseData');
      final UploadResponse uploadResponse =
          UploadResponse.fromJson((json.decode(responseData)));
      return uploadResponse;
    } else {
      debugPrint('False response $responseData');
      throw Exception("Upload file error");
    }
  }

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
}
