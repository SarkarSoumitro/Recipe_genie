import 'dart:typed_data';

import 'package:google_generative_ai/google_generative_ai.dart';
import '../../../../core/errors/failure.dart';

abstract class VisionRemoteDataSource {
  Future<List<String>> identifyFood(Uint8List imageBytes);
}

class VisionRemoteDataSourceImpl implements VisionRemoteDataSource {
  final GenerativeModel _model;

  VisionRemoteDataSourceImpl(this._model);

  @override
  Future<List<String>> identifyFood(Uint8List imageBytes) async {
    try {
      final prompt = 'Identify the food items in this image and return them as a comma-separated list. Do not include any other text.';
      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart('image/jpeg', imageBytes),
        ])
      ];

      final response = await _model.generateContent(content);
      
      if (response.text == null) {
        throw const ServerFailure('No response from Gemini API');
      }

      // Basic parsing: split by comma, trim, filter empty
      final items = response.text!
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      return items;
    } catch (e) {
      throw ServerFailure('Gemini API Error: $e');
    }
  }
}
