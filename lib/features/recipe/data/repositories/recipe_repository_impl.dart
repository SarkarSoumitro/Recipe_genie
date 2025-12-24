import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasources/recipe_remote_data_source.dart';
import '../models/recipe_model.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource _remoteDataSource;

  RecipeRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Recipe>>> generateRecipes(List<String> ingredients) async {
    try {
      final recipes = await _remoteDataSource.generateRecipes(ingredients);
      return Right(recipes);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
