import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart' hide ServerException;
import '../../../../core/errors/exceptions.dart';
import '../models/recipe_model.dart';

abstract class RecipeRemoteDataSource {
  Future<List<Recipe>> generateRecipes(List<String> ingredients);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final GenerativeModel _model;

  RecipeRemoteDataSourceImpl(this._model);

  @override
  Future<List<Recipe>> generateRecipes(List<String> ingredients) async {
    final prompt = '''
    Act as a Master Chef. Using these ingredients: ${ingredients.join(', ')}, suggest 3 recipes.
    Return the response in a valid JSON format with fields: title, ingredients_list (list of strings), and instructions (list of strings).
    Do not include any markdown formatting or code blocks, just the raw JSON array.
    ''';

    final content = [Content.text(prompt)];
    final response = await _model.generateContent(content);

    if (response.text == null) {
      throw const ServerException('No response from AI');
    }

    try {
      final String jsonString = response.text!.replaceAll('```json', '').replaceAll('```', '').trim();
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Recipe.fromJson(json)).toList();
    } catch (e) {
      throw ServerException('Failed to parse recipe JSON: $e');
    }
  }
}

class RecipeRemoteDataSourceMock implements RecipeRemoteDataSource {
  @override
  Future<List<Recipe>> generateRecipes(List<String> ingredients) async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      Recipe(
        title: 'Mock ${ingredients.first} Pasta',
        ingredients: [...ingredients, 'Pasta', 'Olive Oil', 'Garlic'],
        instructions: [
          'Boil pasta according to package instructions.',
          'Sauté garlic in olive oil.',
          'Mix everything together.',
          'Serve hot.'
        ],
      ),
      Recipe(
        title: 'Grilled ${ingredients.first} Salad',
        ingredients: [...ingredients, 'Lettuce', 'Vinaigrette'],
        instructions: [
          'Chop all ingredients.',
          'Toss with vinaigrette.',
          'Season with salt and pepper.'
        ],
      ),
       Recipe(
        title: 'Spicy ${ingredients.first} Stir-fry',
        ingredients: [...ingredients, 'Soy Sauce', 'Chili Flakes'],
        instructions: [
          'Heat oil in a wok.',
          'Stir-fry ingredients rapidly.',
          'Add soy sauce and chili.',
          'Serve with rice.'
        ],
      ),
    ];
  }
}
