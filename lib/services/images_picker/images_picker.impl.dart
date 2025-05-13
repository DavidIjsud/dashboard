import 'images_picker.dart';
import 'package:image_picker/image_picker.dart';

class ImagesPickerImpl implements ImagesPicker {
  ImagesPickerImpl({required ImagePicker picker}) : pickerImage = picker;

  final ImagePicker pickerImage;

  @override
  Future<String> pickImage() async {
    final XFile? image = await pickerImage.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) {
      return '';
    } else {
      return image.path;
    }
  }
}
