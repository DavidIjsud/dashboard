import 'package:image_picker/image_picker.dart';

import 'images_picker.dart';

class ImagesPickerImpl implements ImagesPicker {
  ImagesPickerImpl({required ImagePicker picker}) : pickerImage = picker;

  final ImagePicker pickerImage;

  @override
  Future<XFile?> pickImage() async {
    final XFile? image = await pickerImage.pickImage(source: ImageSource.gallery);

    return image;
  }

  @override
  MimeImageType getMimeType(String mimeType) {
    return MimeImageType.fromString(mimeType);
  }

  @override
  bool isCorrectImageMimeType(String mimeType) {
    final mimeTypeResylt = getMimeType(mimeType);
    return mimeTypeResylt == MimeImageType.png ||
        mimeTypeResylt == MimeImageType.jpg ||
        mimeTypeResylt == MimeImageType.jpeg;
  }
}
