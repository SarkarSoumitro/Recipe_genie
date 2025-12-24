import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import '../../data/models/recipe_model.dart';

part 'recipe_state.freezed.dart';

@freezed
sealed class RecipeState with _$RecipeState {
  const factory RecipeState({
    @Default([]) List<Recipe> recipes,
    @Default({}) Map<String, Product?> nutritionInfo,
    @Default(false) bool isLoading,
    String? error,
  }) = _RecipeState;
}
