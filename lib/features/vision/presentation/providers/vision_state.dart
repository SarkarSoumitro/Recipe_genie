import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'vision_state.freezed.dart';

@freezed
sealed class VisionState with _$VisionState {
  // Freezed definition
  const factory VisionState({
    XFile? selectedImage,
    Uint8List? selectedImageBytes,
    @Default([]) List<String> identifiedIngredients,
    @Default(false) bool isLoading,
    String? error,
  }) = _VisionState;
}
