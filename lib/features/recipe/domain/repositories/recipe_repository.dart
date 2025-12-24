import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';
import '../../data/models/recipe_model.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<Recipe>>> generateRecipes(List<String> ingredients);
}
