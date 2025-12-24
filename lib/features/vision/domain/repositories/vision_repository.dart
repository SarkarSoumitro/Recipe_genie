import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';
import 'package:image_picker/image_picker.dart';

abstract class VisionRepository {
  /// Picks an image from the specified source (camera or gallery).
  Future<Either<Failure, XFile?>> pickImage(ImageSource source);

  /// Identifies food items in the given image.
  /// Returns a list of food item names.
  Future<Either<Failure, List<String>>> identifyFood(XFile image);
}
