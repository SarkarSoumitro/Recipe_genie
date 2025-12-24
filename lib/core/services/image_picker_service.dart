import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker;

  ImagePickerService(this._picker);

  Future<XFile?> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      return image;
    } catch (e) {
      // Handle or rethrow as specific exception
      throw Exception('Failed to pick image: $e');
    }
  }
}
