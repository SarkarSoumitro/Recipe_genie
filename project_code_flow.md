# Recipe Genie Project Source Code

This document contains the source code for the Recipe Genie project, organized by execution flow and logical structure.

## 1. Configuration & Dependencies

### `pubspec.yaml`
```yaml
name: recipe_genie
description: "A new Flutter project."
publish_to: 'none' 

version: 1.0.0+1

environment:
  sdk: ^3.8.1

dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.8
  flutter_riverpod: ^3.0.3
  riverpod_annotation: ^3.0.3
  google_generative_ai: ^0.4.7
  image_picker: ^1.2.1
  openfoodfacts: ^3.28.0
  flutter_card_swiper: ^7.2.0
  json_annotation: ^4.9.0
  freezed_annotation: ^3.1.0
  fpdart: ^1.2.0
  google_fonts: ^6.3.2
  flutter_animate: ^4.5.2
  shimmer: ^3.0.0
  glassmorphism: ^3.0.0
  flutter_staggered_grid_view: ^0.7.0
  font_awesome_flutter: ^10.9.1
  flutter_localizations:
    sdk: flutter
  intl: ^0.20.2
  shared_preferences: ^2.5.3

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^5.0.0
  build_runner: ^2.7.1
  riverpod_generator: ^3.0.3
  freezed: ^3.2.3
  json_serializable: ^6.11.2
  flutter_launcher_icons: ^0.14.4

flutter_launcher_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/images/logo.png"
  min_sdk_android: 21 # android min sdk min:16, default 21

flutter:
  uses-material-design: true
  generate: true

  assets:
    - assets/images/
```

## 2. Entry Point

### `lib/main.dart`
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

import 'core/theme/app_theme.dart';
import 'features/splash/presentation/pages/splash_page.dart';
import 'core/providers/locale_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OpenFoodAPIConfiguration.userAgent = UserAgent(
    name: 'RecipeGenie',
    url: 'https://example.com',
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Genie',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SplashPage(),
    );
  }
}
```

## 3. Localization

### `lib/l10n/app_en.arb`
```json
{
  "appTitle": "Recipe Genie",
  "camera": "Camera",
  "gallery": "Gallery",
  "findIngredients": "Find Ingredients",
  "foundIngredients": "Found Ingredients",
  "generateRecipes": "Generate Recipes",
  "emptyStateMessage": "Your fridge is a canvas...",
  "emptyStateSubMessage": "Tap camera to find paint (ingredients)!",
  "settings": "Settings",
  "language": "Language",
  "recipes": "Recipes",
  "ingredients": "Ingredients",
  "instructions": "Instructions",
  "calories": "kcal",
  "minutes": "mins",
  "easy": "Easy",
  "medium": "Medium",
  "hard": "Hard",
  "error": "Error",
  "noRecipesFound": "No recipes found.",
  "chefsSelection": "Chef's Selection"
}
```

### `lib/l10n/app_bn.arb`
```json
{
  "appTitle": "রেসিপি জিনি",
  "camera": "ক্যামেরা",
  "gallery": "গ্যালারি",
  "findIngredients": "উপকরণ খুঁজুন",
  "foundIngredients": "পাওয়া উপকরণগুলো",
  "generateRecipes": "রেসিপি তৈরি করুন",
  "emptyStateMessage": "আপনার ফ্রিজ একটি ক্যানভাস...",
  "emptyStateSubMessage": "উপকরণ খুঁজতে ক্যামেরা ট্যাপ করুন!",
  "settings": "সেটিংস",
  "language": "ভাষা",
  "recipes": "রেসিপি",
  "ingredients": "উপকরণ",
  "instructions": "নির্দেশনা",
  "calories": "ক্যালোরি",
  "minutes": "মিনিট",
  "easy": "সহজ",
  "medium": "মাঝারি",
  "hard": "কঠিন",
  "error": "ত্রুটি",
  "noRecipesFound": "কোনো রেসিপি পাওয়া যায়নি।",
  "chefsSelection": "শেফের পছন্দ"
}
```

## 4. Core (Theming, Constants, Services)

### `lib/core/theme/app_theme.dart`
```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary: Apricot Crush (Pantone 2025)
  static const Color apricotCrush = Color(0xFFFB9062);
  
  // Backgrounds
  static const Color stoneBlue = Color(0xFFE6EBF0); // Light mode bg assumption
  static const Color offWhite = Color(0xFFF8F9FA);
  static const Color deepCharcoal = Color(0xFF121212); // Dark mode bg
  
  // Accents
  static const Color limeGreen = Color(0xFFC7F464); // "Healthy" indicator
  static const Color glassWhite = Colors.white;
  static const Color glassBlack = Colors.black;
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.apricotCrush,
      scaffoldBackgroundColor: AppColors.offWhite,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.apricotCrush,
        brightness: Brightness.light,
        surface: AppColors.stoneBlue,
      ),
      textTheme: _buildTextTheme(Brightness.light),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.apricotCrush,
      scaffoldBackgroundColor: AppColors.deepCharcoal,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.apricotCrush,
        brightness: Brightness.dark,
        surface: const Color(0xFF1E1E1E),
      ),
      textTheme: _buildTextTheme(Brightness.dark),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
    );
  }

  static TextTheme _buildTextTheme(Brightness brightness) {
    final baseTextTheme = brightness == Brightness.light
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return baseTextTheme.copyWith(
      // Headings - Playfair Display (Serif)
      displayLarge: GoogleFonts.playfairDisplay(textStyle: baseTextTheme.displayLarge, fontWeight: FontWeight.bold),
      displayMedium: GoogleFonts.playfairDisplay(textStyle: baseTextTheme.displayMedium, fontWeight: FontWeight.bold),
      displaySmall: GoogleFonts.playfairDisplay(textStyle: baseTextTheme.displaySmall, fontWeight: FontWeight.bold),
      headlineLarge: GoogleFonts.playfairDisplay(textStyle: baseTextTheme.headlineLarge, fontWeight: FontWeight.bold),
      headlineMedium: GoogleFonts.playfairDisplay(textStyle: baseTextTheme.headlineMedium, fontWeight: FontWeight.bold),
      headlineSmall: GoogleFonts.playfairDisplay(textStyle: baseTextTheme.headlineSmall, fontWeight: FontWeight.bold),
      
      // Body - Inter (Sans-Serif)
      titleLarge: GoogleFonts.inter(textStyle: baseTextTheme.titleLarge, fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.inter(textStyle: baseTextTheme.titleMedium, fontWeight: FontWeight.w500),
      titleSmall: GoogleFonts.inter(textStyle: baseTextTheme.titleSmall),
      bodyLarge: GoogleFonts.inter(textStyle: baseTextTheme.bodyLarge),
      bodyMedium: GoogleFonts.inter(textStyle: baseTextTheme.bodyMedium),
      bodySmall: GoogleFonts.inter(textStyle: baseTextTheme.bodySmall),
      labelLarge: GoogleFonts.inter(textStyle: baseTextTheme.labelLarge, fontWeight: FontWeight.bold),
    );
  }
}
```

### `lib/core/constants/api_constants.dart`
```dart
class ApiConstants {
  // Replace with your actual Gemini API Key
  static const String geminiApiKey = 'AIzaSyCCIIYZhTVRQBSUeVwTRBFUZb6y2wC3zYI';
}
```

### `lib/core/errors/failure.dart`
```dart
abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
```

### `lib/core/providers/locale_provider.dart`
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Keys
const String _kLocaleKey = 'app_locale';

// Notifier
class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    _loadLocale();
    return const Locale('en');
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? localeCode = prefs.getString(_kLocaleKey);
    if (localeCode != null) {
      state = Locale(localeCode);
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLocaleKey, locale.languageCode);
  }
  
  void toggleLocale() {
      if (state.languageCode == 'en') {
          setLocale(const Locale('bn'));
      } else {
          setLocale(const Locale('en'));
      }
  }
}

// Provider
final localeProvider = NotifierProvider<LocaleNotifier, Locale>(() {
  return LocaleNotifier();
});
```

### `lib/core/services/image_picker_service.dart`
```dart
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker;

  ImagePickerService(this._picker);

  Future<XFile?> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      return image;
    } catch (e) {
      // Handle or rethrow as specific exception
      throw Exception('Failed to pick image: $e');
    }
  }
}
```

## 5. Feature: Splash

### `lib/features/splash/presentation/pages/splash_page.dart`
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'dart:ui';
import 'package:recipe_genie/core/theme/app_theme.dart';
import 'package:recipe_genie/features/vision/presentation/pages/vision_page.dart';
import 'package:recipe_genie/l10n/app_localizations.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final List<String> _loadingMessages = [
    "Sharpening the knives...",
    "Preheating the oven...",
    "Gathering fresh inspiration...",
    "Waking up the Genie...",
  ];
  int _messageIndex = 0;

  @override
  void initState() {
    super.initState();
    // Simulate loading progress alongside animations
    _cycleMessages();
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        _navigateToHome();
      }
    });
  }

  void _cycleMessages() async {
    while (mounted) {
      await Future.delayed(const Duration(milliseconds: 1500));
      if (mounted) {
        setState(() {
          _messageIndex = (_messageIndex + 1) % _loadingMessages.length;
        });
      }
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const VisionPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background Image + Blur
          Image.asset(
            'assets/images/kitchen_bg.png',
            fit: BoxFit.cover,
          ).animate().fadeIn(duration: 800.ms),

          // 2. Apricot Crush Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.apricotCrush.withOpacity(0.3),
                  AppColors.apricotCrush.withOpacity(0.8),
                ],
              ),
            ),
          ).animate().fadeIn(duration: 800.ms),

          // 3. Center Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Glassmorphic Square with Logo
                GlassmorphicContainer(
                  width: 200,
                  height: 200,
                  borderRadius: 30,
                  blur: 20,
                  alignment: Alignment.center,
                  border: 2,
                  linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.4),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                  borderGradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.6),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Logo
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Image.asset('assets/images/logo.png'),
                      ),
                      // Pulsing Glow (Lightbulb effect simulation)
                      Positioned(
                        top: 40,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.0),
                            boxShadow: [
                                BoxShadow(color: Colors.white.withOpacity(0.8), blurRadius: 30, spreadRadius: 10)
                            ]
                          ),
                        ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                         .fadeIn(duration: 1.seconds)
                         .then().fadeOut(duration: 1.seconds),
                      )
                    ],
                  ),
                )
                .animate()  
                .scale(duration: 600.ms, curve: Curves.easeOutBack, delay: 500.ms) // Pop in
                .then()
                .moveY(end: -20, duration: 2.seconds, curve: Curves.easeInOutSine) // Floating
                .then()
                .moveY(end: 0, duration: 2.seconds, curve: Curves.easeInOutSine), // Floating down

                const SizedBox(height: 30),

                // App Title
                Text(
                  AppLocalizations.of(context)!.appTitle.toUpperCase(),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ).animate().fadeIn(duration: 800.ms, delay: 1200.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: 50),

                // Scanning Line / Progress
                SizedBox(
                  width: 200,
                  height: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.limeGreen),
                    ),
                  ),
                ).animate().fadeIn(delay: 1500.ms),

                const SizedBox(height: 16),

                // Loading Status Text
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    _loadingMessages[_messageIndex],
                    key: ValueKey<int>(_messageIndex),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ).animate().fadeIn(delay: 1500.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

## 6. Feature: Vision (Home)

### `lib/features/vision/domain/repositories/vision_repository.dart`
```dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';
import 'package:image_picker/image_picker.dart';

abstract class VisionRepository {
  /// Picks an image from the specified source (camera or gallery).
  Future<Either<Failure, XFile?>> pickImage(ImageSource source);

  /// Identifies food items in the given image.
  /// Returns a list of food item names.
  Future<Either<Failure, List<String>>> identifyFood(XFile image);
}
```

### `lib/features/vision/data/datasources/vision_remote_data_source.dart`
```dart
import 'dart:typed_data';

import 'package:google_generative_ai/google_generative_ai.dart';
import '../../../../core/errors/failure.dart';

abstract class VisionRemoteDataSource {
  Future<List<String>> identifyFood(Uint8List imageBytes);
}

class VisionRemoteDataSourceImpl implements VisionRemoteDataSource {
  final GenerativeModel _model;

  VisionRemoteDataSourceImpl(this._model);

  @override
  Future<List<String>> identifyFood(Uint8List imageBytes) async {
    try {
      final prompt = 'Identify the food items in this image and return them as a comma-separated list. Do not include any other text.';
      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart('image/jpeg', imageBytes),
        ])
      ];

      final response = await _model.generateContent(content);
      
      if (response.text == null) {
        throw const ServerFailure('No response from Gemini API');
      }

      // Basic parsing: split by comma, trim, filter empty
      final items = response.text!
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      return items;
    } catch (e) {
      throw ServerFailure('Gemini API Error: $e');
    }
  }
}
```

### `lib/features/vision/data/repositories/vision_repository_impl.dart`
```dart
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/image_picker_service.dart';
import '../../domain/repositories/vision_repository.dart';
import '../datasources/vision_remote_data_source.dart';

class VisionRepositoryImpl implements VisionRepository {
  final VisionRemoteDataSource _remoteDataSource;
  final ImagePickerService _imagePickerService;

  VisionRepositoryImpl(this._remoteDataSource, this._imagePickerService);

  @override
  Future<Either<Failure, XFile?>> pickImage(ImageSource source) async {
    try {
      final image = await _imagePickerService.pickImage(source);
      return Right(image);
    } catch (e) {
      return Left(ValidationFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> identifyFood(XFile image) async {
    try {
      final bytes = await image.readAsBytes();
      final result = await _remoteDataSource.identifyFood(bytes);
      return Right(result);
    } on Failure catch (e) {
      print('VisionRepositoryImpl Error (Failure): ${e.message}');
      return Left(e);
    } catch (e) {
      print('VisionRepositoryImpl Error (Exception): $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
```

### `lib/features/vision/presentation/providers/vision_state.dart`
```dart
import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'vision_state.freezed.dart';

@freezed
sealed class VisionState with _$VisionState {
  // Freezed definition
  const factory VisionState({
    XFile? selectedImage,
    Uint8List? selectedImageBytes,
    @Default([]) List<String> identifiedIngredients,
    @Default(false) bool isLoading,
    String? error,
  }) = _VisionState;
}
```

### `lib/features/vision/presentation/providers/vision_providers.dart`
```dart
import 'dart:typed_data';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/services/image_picker_service.dart';
import '../../data/datasources/vision_remote_data_source.dart';
import '../../data/repositories/vision_repository_impl.dart';
import '../../domain/repositories/vision_repository.dart';
import 'vision_state.dart';
import '../../data/datasources/vision_remote_data_source_mock.dart';

part 'vision_providers.g.dart';

@riverpod
ImagePickerService imagePickerService(Ref ref) {
  return ImagePickerService(ImagePicker());
}

@riverpod
GenerativeModel generativeModel(Ref ref) {
  return GenerativeModel(
    model: 'gemini-2.5-flash-lite', 
    apiKey: ApiConstants.geminiApiKey,
  );
}



@riverpod
VisionRemoteDataSource visionRemoteDataSource(Ref ref) {
  // Use REAL implementation
  return VisionRemoteDataSourceImpl(ref.watch(generativeModelProvider));
  // return VisionRemoteDataSourceMock();
}

@riverpod
VisionRepository visionRepository(Ref ref) {
  return VisionRepositoryImpl(
    ref.watch(visionRemoteDataSourceProvider),
    ref.watch(imagePickerServiceProvider),
  );
}

@riverpod
class VisionController extends _$VisionController {
  @override
  VisionState build() {
    return const VisionState();
  }

  Future<void> pickImage(ImageSource source) async {
    state = state.copyWith(isLoading: true, error: null);
    final repository = ref.read(visionRepositoryProvider);
    final result = await repository.pickImage(source);
    
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, error: failure.message),
      (image) async {
        Uint8List? bytes;
        if (image != null) {
          bytes = await image.readAsBytes();
        }
        state = state.copyWith(isLoading: false, selectedImage: image, selectedImageBytes: bytes, identifiedIngredients: []);
        if (image != null) {
          analyzeImage(image);
        }
      },
    );
  }

  Future<void> analyzeImage(XFile image) async {
    state = state.copyWith(isLoading: true);
    final repository = ref.read(visionRepositoryProvider);
    final result = await repository.identifyFood(image);

    result.fold(
      (failure) => state = state.copyWith(isLoading: false, error: failure.message),
      (ingredients) => state = state.copyWith(isLoading: false, identifiedIngredients: ingredients),
    );
  }
  
  void reset() {
    state = const VisionState();
  }
}
```

### `lib/features/vision/presentation/pages/vision_page.dart`
```dart
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
```

## 7. Feature: Recipe

### `lib/features/recipe/data/models/recipe_model.dart`
```dart
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
```

### `lib/features/recipe/domain/repositories/recipe_repository.dart`
```dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failure.dart';
import '../../data/models/recipe_model.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<Recipe>>> generateRecipes(List<String> ingredients);
}
```

### `lib/features/recipe/data/datasources/recipe_remote_data_source.dart`
```dart
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
```

### `lib/features/recipe/data/repositories/recipe_repository_impl.dart`
```dart
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
```

### `lib/features/recipe/presentation/providers/recipe_state.dart`
```dart
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
```

### `lib/features/recipe/presentation/providers/recipe_providers.dart`
```dart
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
```

### `lib/features/recipe/presentation/pages/recipe_page.dart`
```dart
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
```

## 8. Feature: Nutrition

### `lib/features/nutrition/data/datasources/nutrition_service.dart`
```dart
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
```
