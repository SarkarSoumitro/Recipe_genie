import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../providers/recipe_providers.dart';
import '../../data/models/recipe_model.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:recipe_genie/l10n/app_localizations.dart';

class RecipePage extends ConsumerStatefulWidget {
  final List<String> ingredients;

  const RecipePage({super.key, required this.ingredients});

  @override
  ConsumerState<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends ConsumerState<RecipePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(recipeControllerProvider.notifier).generateRecipes(widget.ingredients);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recipeControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(AppLocalizations.of(context)!.chefsSelection, style: theme.textTheme.headlineMedium?.copyWith(color: AppColors.apricotCrush)),
              centerTitle: true,
            ),
          ),
          
          if (state.isLoading)
             _buildShimmerLoading()
          else if (state.error != null)
             SliverToBoxAdapter(child: Center(child: Text("${AppLocalizations.of(context)!.error}: ${state.error}", style: const TextStyle(color: Colors.red))))
          else if (state.recipes.isEmpty)
             SliverToBoxAdapter(child: Center(child: Text(AppLocalizations.of(context)!.noRecipesFound)))
          else
            _buildRecipeGrid(state.recipes, state.nutritionInfo),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
      return SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverMasonryGrid.extent(
              maxCrossAxisExtent: 300,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childCount: 6,
              itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                          height: (index % 2 == 0) ? 200 : 300,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                          ),
                      ),
                  );
              },
          ),
      );
  }

  Widget _buildRecipeGrid(List<Recipe> recipes, Map<String, Product?> nutritionInfo) {
      return SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverMasonryGrid.extent(
              maxCrossAxisExtent: 300, // Responsive: Items will be max 300px wide
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childCount: recipes.length,
              itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  
                  return _buildRecipeCard(context, recipe, index, nutritionInfo)
                      .animate()
                      .fadeIn(duration: 600.ms, delay: (100 * index).ms)
                      .slideY(begin: 0.2, end: 0, curve: Curves.easeOut);
              },
          ),
      );
  }

  Widget _buildRecipeCard(BuildContext context, Recipe recipe, int index, Map<String, Product?> nutritionInfo) {
      // Calculate total calories roughly
      int totalKcal = 0;
      for (var ing in recipe.ingredients) {
           final product = nutritionInfo[ing];
           if (product?.nutriments != null) {
               final k = product!.nutriments!.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams);
               if (k != null) totalKcal += k.toInt(); // Very rough approx per 100g -> serving
           }
      }
      
      // Random "Height" assignment for Bento effect if text is short
      
      return GestureDetector(
          onTap: () {
               // Detail View could be added here
               _showRecipeDetails(context, recipe, nutritionInfo);
          },
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 4))
                  ]
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      // Image Placeholder (In real app, generated image would go here)
                      Container(
                          height: 120,
                          decoration: BoxDecoration(
                              color: AppColors.apricotCrush.withOpacity(0.1),
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                          child: Center(child: Icon(FontAwesomeIcons.bowlFood, color: AppColors.apricotCrush, size: 40)),
                      ),
                      
                      Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Text(
                                      recipe.title,
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  
                                  // Chips
                                  Wrap(
                                      spacing: 4,
                                      runSpacing: 4,
                                      children: [
                                          _buildInfoChip(Icons.timer, "20m", Colors.blue),
                                          if (totalKcal > 0) _buildInfoChip(FontAwesomeIcons.fire, "${totalKcal}k", Colors.orange),
                                          _buildInfoChip(Icons.bar_chart, "Easy", Colors.green),
                                      ],
                                  ),
                                  
                                  const SizedBox(height: 12),
                                  Text(
                                      "${recipe.ingredients.length} ${AppLocalizations.of(context)!.ingredients}",
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                                  ),
                              ],
                          ),
                      )
                  ],
              ),
          ),
      );
  }
  
  Widget _buildInfoChip(IconData icon, String label, Color color) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                  Icon(icon, size: 12, color: color),
                  const SizedBox(width: 4),
                  Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
              ],
          ),
      );
  }

  void _showRecipeDetails(BuildContext context, Recipe recipe, Map<String, Product?> nutritionInfo) {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => DraggableScrollableSheet(
              initialChildSize: 0.8,
              minChildSize: 0.5,
              maxChildSize: 0.95,
              builder: (context, scrollController) {
                  return GlassmorphicContainer(
                       width: double.infinity,
                       height: double.infinity,
                       borderRadius: 30, // Top rounded
                       blur: 20,
                       alignment: Alignment.center,
                       border: 0,
                       linearGradient: LinearGradient(
                           begin: Alignment.topLeft,
                           end: Alignment.bottomRight,
                           colors: [Colors.white, Colors.white.withOpacity(0.9)],
                       ),
                       borderGradient: LinearGradient(colors: [Colors.white, Colors.white]),
                       child: ListView(
                           controller: scrollController,
                           padding: const EdgeInsets.all(24),
                           children: [
                               Center(child: Container(width: 40, height: 4, color: Colors.grey[300])),
                               const SizedBox(height: 24),
                               Text(recipe.title, style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppColors.apricotCrush)),
                               const SizedBox(height: 24),
                               
                               Text(AppLocalizations.of(context)!.ingredients, style: Theme.of(context).textTheme.headlineSmall),
                               const SizedBox(height: 12),
                               ...recipe.ingredients.map((ing) {
                                   final product = nutritionInfo[ing];
                                   String cal = "";
                                   if (product != null && product.nutriments != null) {
                                       final k = product.nutriments!.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams);
                                       if (k != null) cal = "(${k.toInt()} ${AppLocalizations.of(context)!.calories})";
                                   }
                                   return ListTile(
                                       leading: const Icon(Icons.check_circle_outline, color: AppColors.limeGreen),
                                       title: Text(ing),
                                       trailing: Text(cal, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                   );
                               }),
                               
                               const Divider(height: 48),
                               Text(AppLocalizations.of(context)!.instructions, style: Theme.of(context).textTheme.headlineSmall),
                               const SizedBox(height: 12),
                               ...recipe.instructions.asMap().entries.map((e) => Padding(
                                   padding: const EdgeInsets.only(bottom: 16),
                                   child: Row(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                           CircleAvatar(
                                               radius: 12,
                                               backgroundColor: AppColors.apricotCrush,
                                               child: Text("${e.key + 1}", style: const TextStyle(fontSize: 12, color: Colors.white)),
                                           ),
                                           const SizedBox(width: 12),
                                           Expanded(child: Text(e.value, style: Theme.of(context).textTheme.bodyLarge)),
                                       ],
                                   ),
                               )),
                           ],
                       ),
                  );
              },
          ),
      );
  }
}
