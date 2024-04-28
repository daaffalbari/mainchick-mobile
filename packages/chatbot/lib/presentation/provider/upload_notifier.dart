import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

import '../../data/datasources/chatbot_remote_data_sources.dart';
import '../../data/models/upload_response.dart';

class UploadNotifier extends ChangeNotifier {
  final ChatBotRemoteDataSourceImpl apiService;

  UploadNotifier(this.apiService);

  bool isUploading = false;
  String message = "";
  UploadResponse? uploadResponse;

  Future<void> upload(List<int> bytes, String fileName) async {
    try {
      message = "";
      uploadResponse = null;
      isUploading = true;
      notifyListeners();

      uploadResponse = await apiService.uploadImage(bytes, fileName);
      message = uploadResponse?.iteration ?? "success";
      isUploading = false;
      notifyListeners();
    } catch (e) {
      isUploading = false;
      message = e.toString();
      notifyListeners();
    }
  }

  Future<List<int>> compressImage(Uint8List bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;

    final img.Image image = img.decodeImage(bytes)!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];

    do {
      ///
      compressQuality -= 10;

      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );

      length = newByte.length;
    } while (length > 1000000);

    return newByte;
  }
}
