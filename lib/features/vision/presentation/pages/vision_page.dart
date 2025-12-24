import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_genie/features/recipe/presentation/pages/recipe_page.dart';
import 'package:recipe_genie/l10n/app_localizations.dart';

import '../../../../core/providers/locale_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/vision_providers.dart';

class VisionPage extends ConsumerWidget {
  const VisionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(visionControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.appTitle,
          style: theme.textTheme.displaySmall,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final locale = ref.watch(localeProvider);
              return IconButton(
                icon: Text(
                  locale.languageCode == 'en' ? '🇧🇩' : '🇺🇸',
                  style: const TextStyle(fontSize: 24),
                ),
                onPressed: () {
                  ref.read(localeProvider.notifier).toggleLocale();
                },
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.scaffoldBackgroundColor,
                  AppColors.apricotCrush.withOpacity(0.1),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Center(
              // Center content on large screens
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ), // Max width for tablet/desktop
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: _buildCameraFeed(context, state, ref),
                      ),
                    ),
                    _buildControls(context, state, ref),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraFeed(BuildContext context, dynamic state, WidgetRef ref) {
    bool hasImage = state.selectedImageBytes != null;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.apricotCrush.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image or Placeholder
            if (hasImage)
              Image.memory(state.selectedImageBytes!, fit: BoxFit.cover)
            else
              _buildEmptyState(context),

            // Scanner Overlay
            if (state.isLoading) _buildScannerAnimation(),

            // Smart Dots (Simulated)
            if (hasImage && !state.isLoading)
              ...List.generate(3, (index) => _buildSmartDot(index)),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).moveY(begin: 20, end: 0);
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(FontAwesomeIcons.utensils, size: 60, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.emptyStateMessage,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.emptyStateSubMessage,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerAnimation() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: 2.seconds,
      builder: (context, value, child) {
        return Align(
          alignment: Alignment(0, -1 + (value * 2)),
          child: Container(
            height: 4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.apricotCrush,
              boxShadow: [
                BoxShadow(
                  color: AppColors.apricotCrush.withOpacity(0.8),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        );
      },
      onEnd: () {},
    ).animate(onPlay: (controller) => controller.repeat());
  }

  Widget _buildSmartDot(int index) {
    final random = Random(index);
    return Positioned(
      top: 50.0 + random.nextInt(200),
      left: 50.0 + random.nextInt(200),
      child:
          GlassmorphicContainer(
            width: 30,
            height: 30,
            borderRadius: 30,
            blur: 10,
            alignment: Alignment.center,
            border: 1,
            linearGradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.4),
                Colors.white.withOpacity(0.1),
              ],
            ),
            borderGradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.5),
                Colors.white.withOpacity(0.1),
              ],
            ),
            child: const Icon(
              FontAwesomeIcons.check,
              size: 12,
              color: Colors.white,
            ),
          ).animate().scale(
            delay: (200 * index).ms,
            duration: 400.ms,
            curve: Curves.elasticOut,
          ),
    );
  }

  Widget _buildControls(BuildContext context, dynamic state, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Ingredients Popup
          if (state.identifiedIngredients.isNotEmpty)
            _buildIngredientsGlass(context, state.identifiedIngredients, ref),

          const SizedBox(height: 30),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildGlassButton(
                context,
                icon: FontAwesomeIcons.camera,
                label: AppLocalizations.of(context)!.camera,
                onTap: () {
                  HapticFeedback.lightImpact();
                  ref
                      .read(visionControllerProvider.notifier)
                      .pickImage(ImageSource.camera);
                },
              ),
              _buildGlassButton(
                context,
                icon: FontAwesomeIcons.images,
                label: AppLocalizations.of(context)!.gallery,
                onTap: () {
                  HapticFeedback.lightImpact();
                  ref
                      .read(visionControllerProvider.notifier)
                      .pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsGlass(
    BuildContext context,
    List<String> ingredients,
    WidgetRef ref,
  ) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 200, // Increased height
      borderRadius: 20,
      blur: 10, // Reduced blur for performance
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white.withOpacity(0.6), Colors.white.withOpacity(0.1)],
      ),
      borderGradient: LinearGradient(
        colors: [Colors.white.withOpacity(0.6), Colors.white.withOpacity(0.1)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.foundIngredients,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    alignment: WrapAlignment.center,
                    children: ingredients
                        .map(
                          (e) => Chip(
                            label: Text(e),
                            backgroundColor: AppColors.apricotCrush.withOpacity(
                              0.2,
                            ),
                            side: BorderSide.none,
                          ).animate().scale(),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RecipePage(ingredients: ingredients),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.apricotCrush.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "${AppLocalizations.of(context)!.generateRecipes} →",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.apricotCrush,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ).animate().shimmer(duration: 2.seconds, color: Colors.white),
            ),
          ],
        ),
      ),
    ).animate().slideY(begin: 1.0, end: 0, curve: Curves.easeOutBack);
  }

  Widget _buildGlassButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2), // Frosted
              border: Border.all(color: Colors.white.withOpacity(0.4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: AppColors.deepCharcoal, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: Theme.of(context).textTheme.labelLarge),
        ],
      ).animate().scale(duration: 200.ms, curve: Curves.easeInOut),
    );
  }
}
