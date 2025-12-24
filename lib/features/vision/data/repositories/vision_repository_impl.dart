import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/image_picker_service.dart';
import '../../domain/repositories/vision_repository.dart';
import '../datasources/vision_remote_data_source.dart';

class VisionRepositoryImpl implements VisionRepository {
  final VisionRemoteDataSource _remoteDataSource;
  final ImagePickerService _imagePickerService;

  VisionRepositoryImpl(this._remoteDataSource, this._imagePickerService);

  @override
  Future<Either<Failure, XFile?>> pickImage(ImageSource source) async {
    try {
      final image = await _imagePickerService.pickImage(source);
      return Right(image);
    } catch (e) {
      return Left(ValidationFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> identifyFood(XFile image) async {
    try {
      final bytes = await image.readAsBytes();
      final result = await _remoteDataSource.identifyFood(bytes);
      return Right(result);
    } on Failure catch (e) {
      print('VisionRepositoryImpl Error (Failure): ${e.message}');
      return Left(e);
    } catch (e) {
      print('VisionRepositoryImpl Error (Exception): $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
