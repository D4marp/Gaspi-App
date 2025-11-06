// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'do_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deliveryOrderDetailHash() =>
    r'351747b13f2a5c361b9a2e798ca8f72899042a3e';

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

/// Provider untuk detail delivery order
///
/// Copied from [deliveryOrderDetail].
@ProviderFor(deliveryOrderDetail)
const deliveryOrderDetailProvider = DeliveryOrderDetailFamily();

/// Provider untuk detail delivery order
///
/// Copied from [deliveryOrderDetail].
class DeliveryOrderDetailFamily extends Family<AsyncValue<DeliveryOrder>> {
  /// Provider untuk detail delivery order
  ///
  /// Copied from [deliveryOrderDetail].
  const DeliveryOrderDetailFamily();

  /// Provider untuk detail delivery order
  ///
  /// Copied from [deliveryOrderDetail].
  DeliveryOrderDetailProvider call(
    String id,
  ) {
    return DeliveryOrderDetailProvider(
      id,
    );
  }

  @override
  DeliveryOrderDetailProvider getProviderOverride(
    covariant DeliveryOrderDetailProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'deliveryOrderDetailProvider';
}

/// Provider untuk detail delivery order
///
/// Copied from [deliveryOrderDetail].
class DeliveryOrderDetailProvider
    extends AutoDisposeFutureProvider<DeliveryOrder> {
  /// Provider untuk detail delivery order
  ///
  /// Copied from [deliveryOrderDetail].
  DeliveryOrderDetailProvider(
    String id,
  ) : this._internal(
          (ref) => deliveryOrderDetail(
            ref as DeliveryOrderDetailRef,
            id,
          ),
          from: deliveryOrderDetailProvider,
          name: r'deliveryOrderDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deliveryOrderDetailHash,
          dependencies: DeliveryOrderDetailFamily._dependencies,
          allTransitiveDependencies:
              DeliveryOrderDetailFamily._allTransitiveDependencies,
          id: id,
        );

  DeliveryOrderDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<DeliveryOrder> Function(DeliveryOrderDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeliveryOrderDetailProvider._internal(
        (ref) => create(ref as DeliveryOrderDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DeliveryOrder> createElement() {
    return _DeliveryOrderDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeliveryOrderDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DeliveryOrderDetailRef on AutoDisposeFutureProviderRef<DeliveryOrder> {
  /// The parameter `id` of this provider.
  String get id;
}

class _DeliveryOrderDetailProviderElement
    extends AutoDisposeFutureProviderElement<DeliveryOrder>
    with DeliveryOrderDetailRef {
  _DeliveryOrderDetailProviderElement(super.provider);

  @override
  String get id => (origin as DeliveryOrderDetailProvider).id;
}

String _$deliveryOrderListHash() => r'35cadd0c1433e579a7e79ee91c6bffd9cb8d41b3';

/// Provider untuk list delivery orders dengan filter
///
/// Copied from [DeliveryOrderList].
@ProviderFor(DeliveryOrderList)
final deliveryOrderListProvider = AutoDisposeAsyncNotifierProvider<
    DeliveryOrderList, List<DeliveryOrder>>.internal(
  DeliveryOrderList.new,
  name: r'deliveryOrderListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deliveryOrderListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeliveryOrderList = AutoDisposeAsyncNotifier<List<DeliveryOrder>>;
String _$deliveryOrderStatusUpdaterHash() =>
    r'c76560af66d4d74e920124d2d5170f09c073df85';

/// Provider untuk update status
///
/// Copied from [DeliveryOrderStatusUpdater].
@ProviderFor(DeliveryOrderStatusUpdater)
final deliveryOrderStatusUpdaterProvider =
    AutoDisposeAsyncNotifierProvider<DeliveryOrderStatusUpdater, void>.internal(
  DeliveryOrderStatusUpdater.new,
  name: r'deliveryOrderStatusUpdaterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deliveryOrderStatusUpdaterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeliveryOrderStatusUpdater = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
