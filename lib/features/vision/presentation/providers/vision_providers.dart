import 'dart:typed_data';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/services/image_picker_service.dart';
import '../../data/datasources/vision_remote_data_source.dart';
import '../../data/repositories/vision_repository_impl.dart';
import '../../domain/repositories/vision_repository.dart';
import 'vision_state.dart';
import '../../data/datasources/vision_remote_data_source_mock.dart';

part 'vision_providers.g.dart';

@riverpod
ImagePickerService imagePickerService(Ref ref) {
  return ImagePickerService(ImagePicker());
}

@riverpod
GenerativeModel generativeModel(Ref ref) {
  return GenerativeModel(
    model: 'gemini-2.5-flash-lite', 
    apiKey: ApiConstants.geminiApiKey,
  );
}



@riverpod
VisionRemoteDataSource visionRemoteDataSource(Ref ref) {
  // Use REAL implementation
  return VisionRemoteDataSourceImpl(ref.watch(generativeModelProvider));
  // return VisionRemoteDataSourceMock();
}

@riverpod
VisionRepository visionRepository(Ref ref) {
  return VisionRepositoryImpl(
    ref.watch(visionRemoteDataSourceProvider),
    ref.watch(imagePickerServiceProvider),
  );
}

@riverpod
class VisionController extends _$VisionController {
  @override
  VisionState build() {
    return const VisionState();
  }

  Future<void> pickImage(ImageSource source) async {
    state = state.copyWith(isLoading: true, error: null);
    final repository = ref.read(visionRepositoryProvider);
    final result = await repository.pickImage(source);
    
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, error: failure.message),
      (image) async {
        Uint8List? bytes;
        if (image != null) {
          bytes = await image.readAsBytes();
        }
        state = state.copyWith(isLoading: false, selectedImage: image, selectedImageBytes: bytes, identifiedIngredients: []);
        if (image != null) {
          analyzeImage(image);
        }
      },
    );
  }

  Future<void> analyzeImage(XFile image) async {
    state = state.copyWith(isLoading: true);
    final repository = ref.read(visionRepositoryProvider);
    final result = await repository.identifyFood(image);

    result.fold(
      (failure) => state = state.copyWith(isLoading: false, error: failure.message),
      (ingredients) => state = state.copyWith(isLoading: false, identifiedIngredients: ingredients),
    );
  }
  
  void reset() {
    state = const VisionState();
  }
}
