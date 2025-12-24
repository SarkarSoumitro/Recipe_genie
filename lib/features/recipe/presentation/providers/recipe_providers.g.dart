// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(recipeRemoteDataSource)
const recipeRemoteDataSourceProvider = RecipeRemoteDataSourceProvider._();

final class RecipeRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          RecipeRemoteDataSource,
          RecipeRemoteDataSource,
          RecipeRemoteDataSource
        >
    with $Provider<RecipeRemoteDataSource> {
  const RecipeRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recipeRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recipeRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<RecipeRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RecipeRemoteDataSource create(Ref ref) {
    return recipeRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecipeRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecipeRemoteDataSource>(value),
    );
  }
}

String _$recipeRemoteDataSourceHash() =>
    r'4d2abdd9ed5e65d5aaaacbbae46c2afc021929eb';

@ProviderFor(recipeRepository)
const recipeRepositoryProvider = RecipeRepositoryProvider._();

final class RecipeRepositoryProvider
    extends
        $FunctionalProvider<
          RecipeRepository,
          RecipeRepository,
          RecipeRepository
        >
    with $Provider<RecipeRepository> {
  const RecipeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recipeRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recipeRepositoryHash();

  @$internal
  @override
  $ProviderElement<RecipeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RecipeRepository create(Ref ref) {
    return recipeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecipeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecipeRepository>(value),
    );
  }
}

String _$recipeRepositoryHash() => r'400a176fa5e9e0181afd9112c7becbe1447404a8';

@ProviderFor(RecipeController)
const recipeControllerProvider = RecipeControllerProvider._();

final class RecipeControllerProvider
    extends $NotifierProvider<RecipeController, RecipeState> {
  const RecipeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recipeControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recipeControllerHash();

  @$internal
  @override
  RecipeController create() => RecipeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecipeState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecipeState>(value),
    );
  }
}

String _$recipeControllerHash() => r'b8e93ffe628b57e41111126390232b02d1616afb';

abstract class _$RecipeController extends $Notifier<RecipeState> {
  RecipeState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<RecipeState, RecipeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RecipeState, RecipeState>,
              RecipeState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
