// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vision_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(imagePickerService)
const imagePickerServiceProvider = ImagePickerServiceProvider._();

final class ImagePickerServiceProvider
    extends
        $FunctionalProvider<
          ImagePickerService,
          ImagePickerService,
          ImagePickerService
        >
    with $Provider<ImagePickerService> {
  const ImagePickerServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imagePickerServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imagePickerServiceHash();

  @$internal
  @override
  $ProviderElement<ImagePickerService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ImagePickerService create(Ref ref) {
    return imagePickerService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImagePickerService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImagePickerService>(value),
    );
  }
}

String _$imagePickerServiceHash() =>
    r'701c510a8af770566a5fce14f3c4084de09512a8';

@ProviderFor(generativeModel)
const generativeModelProvider = GenerativeModelProvider._();

final class GenerativeModelProvider
    extends
        $FunctionalProvider<GenerativeModel, GenerativeModel, GenerativeModel>
    with $Provider<GenerativeModel> {
  const GenerativeModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'generativeModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$generativeModelHash();

  @$internal
  @override
  $ProviderElement<GenerativeModel> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GenerativeModel create(Ref ref) {
    return generativeModel(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GenerativeModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GenerativeModel>(value),
    );
  }
}

String _$generativeModelHash() => r'4d4490cab585bc4383ba67765df62b88af60819e';

@ProviderFor(visionRemoteDataSource)
const visionRemoteDataSourceProvider = VisionRemoteDataSourceProvider._();

final class VisionRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          VisionRemoteDataSource,
          VisionRemoteDataSource,
          VisionRemoteDataSource
        >
    with $Provider<VisionRemoteDataSource> {
  const VisionRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'visionRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$visionRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<VisionRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VisionRemoteDataSource create(Ref ref) {
    return visionRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VisionRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VisionRemoteDataSource>(value),
    );
  }
}

String _$visionRemoteDataSourceHash() =>
    r'bc5aca668bf2f6394b4a497f3cbb99a2efc2979f';

@ProviderFor(visionRepository)
const visionRepositoryProvider = VisionRepositoryProvider._();

final class VisionRepositoryProvider
    extends
        $FunctionalProvider<
          VisionRepository,
          VisionRepository,
          VisionRepository
        >
    with $Provider<VisionRepository> {
  const VisionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'visionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$visionRepositoryHash();

  @$internal
  @override
  $ProviderElement<VisionRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VisionRepository create(Ref ref) {
    return visionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VisionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VisionRepository>(value),
    );
  }
}

String _$visionRepositoryHash() => r'ff6d07b844a119f2f87e88fd92795c6280384ea1';

@ProviderFor(VisionController)
const visionControllerProvider = VisionControllerProvider._();

final class VisionControllerProvider
    extends $NotifierProvider<VisionController, VisionState> {
  const VisionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'visionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$visionControllerHash();

  @$internal
  @override
  VisionController create() => VisionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VisionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VisionState>(value),
    );
  }
}

String _$visionControllerHash() => r'68669166de3bc65e7e001a028272c5129b848d61';

abstract class _$VisionController extends $Notifier<VisionState> {
  VisionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<VisionState, VisionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<VisionState, VisionState>,
              VisionState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
