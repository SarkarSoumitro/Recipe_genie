import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/recipe_remote_data_source.dart';
import '../../data/repositories/recipe_repository_impl.dart';
import '../../domain/repositories/recipe_repository.dart';

import 'package:openfoodfacts/openfoodfacts.dart';
import '../../../nutrition/data/datasources/nutrition_service.dart';
import '../../../../features/vision/presentation/providers/vision_providers.dart';
import 'recipe_state.dart';

part 'recipe_providers.g.dart';

@riverpod
RecipeRemoteDataSource recipeRemoteDataSource(Ref ref) {
  // Use REAL implementation
  return RecipeRemoteDataSourceImpl(ref.watch(generativeModelProvider));
  // return RecipeRemoteDataSourceMock();
}

@riverpod
RecipeRepository recipeRepository(Ref ref) {
  return RecipeRepositoryImpl(ref.watch(recipeRemoteDataSourceProvider));
}

@riverpod
class RecipeController extends _$RecipeController {
  @override
  RecipeState build() {
    return const RecipeState();
  }

  Future<void> generateRecipes(List<String> ingredients) async {
    state = state.copyWith(isLoading: true, error: null);
    final repository = ref.read(recipeRepositoryProvider);
    final result = await repository.generateRecipes(ingredients);

    result.fold(
      (failure) => state = state.copyWith(isLoading: false, error: failure.message),
      (recipes) async {
         state = state.copyWith(isLoading: false, recipes: recipes);
         
         // Fetch nutrition for ingredients
         final nutritionService = NutritionService();
         final Map<String, Product?> info = {};
         
         // Flatten all ingredients from all recipes
         final allIngredients = recipes.expand((r) => r.ingredients).toSet();
         
         for (final ingredient in allIngredients) {
             // Basic cleaning of ingredient name to improve search hit rate
             final query = ingredient.split(' ').last; // e.g. "Chopped Onions" -> "Onions"
             final product = await nutritionService.getProductNutrition(query);
             info[ingredient] = product;
         }
         
         state = state.copyWith(nutritionInfo: info);
      },
    );
  }
}
