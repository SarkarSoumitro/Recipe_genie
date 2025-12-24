// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Recipe Genie';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get findIngredients => 'Find Ingredients';

  @override
  String get foundIngredients => 'Found Ingredients';

  @override
  String get generateRecipes => 'Generate Recipes';

  @override
  String get emptyStateMessage => 'Your fridge is a canvas...';

  @override
  String get emptyStateSubMessage => 'Tap camera to find paint (ingredients)!';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get recipes => 'Recipes';

  @override
  String get ingredients => 'Ingredients';

  @override
  String get instructions => 'Instructions';

  @override
  String get calories => 'kcal';

  @override
  String get minutes => 'mins';

  @override
  String get easy => 'Easy';

  @override
  String get medium => 'Medium';

  @override
  String get hard => 'Hard';

  @override
  String get error => 'Error';

  @override
  String get noRecipesFound => 'No recipes found.';

  @override
  String get chefsSelection => 'Chef\'s Selection';
}
