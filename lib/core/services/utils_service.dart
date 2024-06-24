
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';


class Utils{

  static Future<String> pickAndConvertImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return "";
    }

    final imageFile = File(pickedFile.path);
    final imageBytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(imageBytes);

    return base64Image;
  }

}


Uint8List convertToImageFromBase64(String base64) {
  final startIndex = base64.indexOf(',');
  if (startIndex != -1) {
    base64 = base64.substring(startIndex + 1);
  }
  Uint8List bytes = base64Decode(base64);
  return bytes;
}