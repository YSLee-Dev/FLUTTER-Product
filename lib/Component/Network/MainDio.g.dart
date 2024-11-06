// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MainDio.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mainDioHash() => r'654cedf7bf781a4c8b29dcc47cf8be99fd58a93e';

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

/// See also [mainDio].
@ProviderFor(mainDio)
const mainDioProvider = MainDioFamily();

/// See also [mainDio].
class MainDioFamily extends Family<Dio> {
  /// See also [mainDio].
  const MainDioFamily();

  /// See also [mainDio].
  MainDioProvider call(
    String baseURL,
  ) {
    return MainDioProvider(
      baseURL,
    );
  }

  @override
  MainDioProvider getProviderOverride(
    covariant MainDioProvider provider,
  ) {
    return call(
      provider.baseURL,
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
  String? get name => r'mainDioProvider';
}

/// See also [mainDio].
class MainDioProvider extends AutoDisposeProvider<Dio> {
  /// See also [mainDio].
  MainDioProvider(
    String baseURL,
  ) : this._internal(
          (ref) => mainDio(
            ref as MainDioRef,
            baseURL,
          ),
          from: mainDioProvider,
          name: r'mainDioProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mainDioHash,
          dependencies: MainDioFamily._dependencies,
          allTransitiveDependencies: MainDioFamily._allTransitiveDependencies,
          baseURL: baseURL,
        );

  MainDioProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.baseURL,
  }) : super.internal();

  final String baseURL;

  @override
  Override overrideWith(
    Dio Function(MainDioRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MainDioProvider._internal(
        (ref) => create(ref as MainDioRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        baseURL: baseURL,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Dio> createElement() {
    return _MainDioProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MainDioProvider && other.baseURL == baseURL;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, baseURL.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MainDioRef on AutoDisposeProviderRef<Dio> {
  /// The parameter `baseURL` of this provider.
  String get baseURL;
}

class _MainDioProviderElement extends AutoDisposeProviderElement<Dio>
    with MainDioRef {
  _MainDioProviderElement(super.provider);

  @override
  String get baseURL => (origin as MainDioProvider).baseURL;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
