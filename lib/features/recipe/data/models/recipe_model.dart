import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_model.freezed.dart';
part 'recipe_model.g.dart';

@freezed
sealed class Recipe with _$Recipe {
  const factory Recipe({
    required String title,
    @JsonKey(name: 'ingredients_list') required List<String> ingredients,
    required List<String> instructions,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}
