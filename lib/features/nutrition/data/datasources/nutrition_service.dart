import 'package:openfoodfacts/openfoodfacts.dart';

class NutritionService {
  Future<Product?> getProductNutrition(String ingredientName) async {
    // Search for the product by name
    final ProductSearchQueryConfiguration configuration =
        ProductSearchQueryConfiguration(
      parametersList: <Parameter>[
        SearchTerms(terms: [ingredientName]),
        const PageSize(size: 1),
      ],
      version: ProductQueryVersion.v3,
    );

    try {
      final SearchResult result =
          await OpenFoodAPIClient.searchProducts(null, configuration);

      if (result.products != null && result.products!.isNotEmpty) {
        return result.products!.first;
      }
    } catch (e) {
      print('Error fetching nutrition for $ingredientName: $e');
    }
    return null;
  }
}
