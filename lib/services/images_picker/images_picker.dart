import 'package:image_picker/image_picker.dart';

enum MimeImageType {
  png,
  jpg,
  jpeg;

  static MimeImageType fromString(String type) {
    switch (type) {
      case 'image/png':
        return MimeImageType.png;
      case 'image/jpg':
        return MimeImageType.jpg;
      case 'image/jpeg':
        return MimeImageType.jpeg;
      default:
        throw Exception('Invalid image type');
    }
  }
}

abstract class ImagesPicker {
  Future<XFile?> pickImage();
  MimeImageType getMimeType(String mimeType);
  bool isCorrectImageMimeType(String mimeType);
}
