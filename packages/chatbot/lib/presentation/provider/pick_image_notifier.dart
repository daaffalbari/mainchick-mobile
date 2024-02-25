import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart' show XFile;

class PickImageNotifier extends ChangeNotifier {
  String? imagePath;

  XFile? imageFile;

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }
}
