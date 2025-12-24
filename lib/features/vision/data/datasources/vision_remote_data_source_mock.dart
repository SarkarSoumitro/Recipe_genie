import 'dart:typed_data';
import 'vision_remote_data_source.dart';

class VisionRemoteDataSourceMock implements VisionRemoteDataSource {
  @override
  Future<List<String>> identifyFood(Uint8List imageBytes) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Return mock data
    return [
      'Tomato',
      'Cheese',
      'Basil',
      'Olive Oil',
      'Pasta',
    ];
  }
}
