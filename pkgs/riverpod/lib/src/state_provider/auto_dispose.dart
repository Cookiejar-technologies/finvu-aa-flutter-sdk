part of '../state_provider.dart';

/// {@macro riverpod.providerrefbase}
/// - [controller], the [StateController] currently exposed by this provider.
abstract class AutoDisposeStateProviderRef<State>
    extends StateProviderRef<State> implements AutoDisposeRef<State> {}

/// {@macro riverpod.stateprovider}
class AutoDisposeStateProvider<T> extends _StateProviderBase<T> {
  /// {@macro riverpod.stateprovider}
  AutoDisposeStateProvider(
    this._createFn, {
    String? name,
    Iterable<ProviderOrFamily>? dependencies,
    @Deprecated('Will be removed in 3.0.0') Family<Object?>? from,
    @Deprecated('Will be removed in 3.0.0') Object? argument,
    @Deprecated('Will be removed in 3.0.0') String Function()? debugGetCreateSourceHash,
  }) : super(
    name: name,
    dependencies: dependencies,
    from: from,
    argument: argument,
    debugGetCreateSourceHash: debugGetCreateSourceHash,
    allTransitiveDependencies: computeAllTransitiveDependencies(dependencies),
  );

  /// An implementation detail of Riverpod
  @internal
  AutoDisposeStateProvider.internal(
    this._createFn, {
    required String? name,
    required Iterable<ProviderOrFamily>? dependencies,
    required Iterable<ProviderOrFamily>? allTransitiveDependencies,
    required String Function()? debugGetCreateSourceHash,
    Family<Object?>? from,
    Object? argument,
  }) : super(name: name, dependencies: dependencies, allTransitiveDependencies: allTransitiveDependencies, debugGetCreateSourceHash: debugGetCreateSourceHash, from: from, argument: argument);


  /// {@macro riverpod.family}
  static const family = AutoDisposeStateProviderFamily.new;

  final T Function(AutoDisposeStateProviderRef<T> ref) _createFn;

  @override
  T _create(AutoDisposeStateProviderElement<T> ref) => _createFn(ref);

  @override
  AutoDisposeStateProviderElement<T> createElement() {
    return AutoDisposeStateProviderElement._(this);
  }

  @override
  late final Refreshable<StateController<T>> notifier = _notifier(this);

  @Deprecated(
    'Will be removed in 3.0.0. '
    'Use either `ref.watch(provider)` or `ref.read(provider.notifier)` instead',
  )
  @override
  late final Refreshable<StateController<T>> state = _state(this);

  /// {@macro riverpod.overridewith}
  Override overrideWith(
    Create<T, AutoDisposeStateProviderRef<T>> create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AutoDisposeStateProvider<T>.internal(
        create,
        from: from,
        argument: argument,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        name: null,
      ),
    );
  }
}

/// The element of [StateProvider].
class AutoDisposeStateProviderElement<T> extends StateProviderElement<T>
    with AutoDisposeProviderElementMixin<T>
    implements AutoDisposeStateProviderRef<T> {
  /// The [ProviderElementBase] for [StateProvider]
  AutoDisposeStateProviderElement._(AutoDisposeStateProvider<T> _provider)
      : super._(_provider);
}

/// The [Family] of [StateProvider].
class AutoDisposeStateProviderFamily<R, Arg> extends AutoDisposeFamilyBase<
    AutoDisposeStateProviderRef<R>, R, Arg, R, AutoDisposeStateProvider<R>> {
  /// The [Family] of [StateProvider].
  AutoDisposeStateProviderFamily(
    R Function(AutoDisposeStateProviderRef<R>, Arg) _createFn, {
    String? name,
    Iterable<ProviderOrFamily>? dependencies,
  }) : super(
    _createFn,
    name: name,
    dependencies: dependencies,
    providerFactory: AutoDisposeStateProvider.internal,
    debugGetCreateSourceHash: null,
    allTransitiveDependencies: computeAllTransitiveDependencies(dependencies),
  );

  /// {@macro riverpod.overridewith}
  Override overrideWith(
    R Function(AutoDisposeStateProviderRef<R> ref, Arg arg) create,
  ) {
    return FamilyOverrideImpl<R, Arg, AutoDisposeStateProvider<R>>(
      this,
      (arg) => AutoDisposeStateProvider<R>.internal(
        (ref) => create(ref, arg),
        from: from,
        argument: arg,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        name: null,
      ),
    );
  }
}
