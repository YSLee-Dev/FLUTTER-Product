// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DetailViewModel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reviewIndexTimerHash() => r'f9a2377eb7d7359f55e893684e37798c857a523a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [reviewIndexTimer].
@ProviderFor(reviewIndexTimer)
const reviewIndexTimerProvider = ReviewIndexTimerFamily();

/// See also [reviewIndexTimer].
class ReviewIndexTimerFamily extends Family<AsyncValue<int>> {
  /// See also [reviewIndexTimer].
  const ReviewIndexTimerFamily();

  /// See also [reviewIndexTimer].
  ReviewIndexTimerProvider call({
    required int reviewsLength,
  }) {
    return ReviewIndexTimerProvider(
      reviewsLength: reviewsLength,
    );
  }

  @override
  ReviewIndexTimerProvider getProviderOverride(
    covariant ReviewIndexTimerProvider provider,
  ) {
    return call(
      reviewsLength: provider.reviewsLength,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'reviewIndexTimerProvider';
}

/// See also [reviewIndexTimer].
class ReviewIndexTimerProvider extends AutoDisposeStreamProvider<int> {
  /// See also [reviewIndexTimer].
  ReviewIndexTimerProvider({
    required int reviewsLength,
  }) : this._internal(
          (ref) => reviewIndexTimer(
            ref as ReviewIndexTimerRef,
            reviewsLength: reviewsLength,
          ),
          from: reviewIndexTimerProvider,
          name: r'reviewIndexTimerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$reviewIndexTimerHash,
          dependencies: ReviewIndexTimerFamily._dependencies,
          allTransitiveDependencies:
              ReviewIndexTimerFamily._allTransitiveDependencies,
          reviewsLength: reviewsLength,
        );

  ReviewIndexTimerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.reviewsLength,
  }) : super.internal();

  final int reviewsLength;

  @override
  Override overrideWith(
    Stream<int> Function(ReviewIndexTimerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReviewIndexTimerProvider._internal(
        (ref) => create(ref as ReviewIndexTimerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        reviewsLength: reviewsLength,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<int> createElement() {
    return _ReviewIndexTimerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReviewIndexTimerProvider &&
        other.reviewsLength == reviewsLength;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, reviewsLength.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ReviewIndexTimerRef on AutoDisposeStreamProviderRef<int> {
  /// The parameter `reviewsLength` of this provider.
  int get reviewsLength;
}

class _ReviewIndexTimerProviderElement
    extends AutoDisposeStreamProviderElement<int> with ReviewIndexTimerRef {
  _ReviewIndexTimerProviderElement(super.provider);

  @override
  int get reviewsLength => (origin as ReviewIndexTimerProvider).reviewsLength;
}

String _$detailViewModelHash() => r'77d6217bc63188abce0239f1a0b98de31268ada5';

/// See also [DetailViewModel].
@ProviderFor(DetailViewModel)
final detailViewModelProvider =
    AutoDisposeNotifierProvider<DetailViewModel, ProductModel>.internal(
  DetailViewModel.new,
  name: r'detailViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$detailViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DetailViewModel = AutoDisposeNotifier<ProductModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
