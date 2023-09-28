part of '../future_provider.dart';

/// {@macro riverpod.providerrefbase}
/// - [FutureProviderRef.state], the value currently exposed by this provider.
abstract class AutoDisposeFutureProviderRef<State>
    extends FutureProviderRef<State>
    implements AutoDisposeRef<AsyncValue<State>> {}

/// {@macro riverpod.futureprovider}
class AutoDisposeFutureProvider<T> extends _FutureProviderBase<T>
    with AsyncSelector<T> {
  /// {@macro riverpod.futureprovider}
  AutoDisposeFutureProvider(
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
  AutoDisposeFutureProvider.internal(
    this._createFn, {
    required String? name,
    required Iterable<ProviderOrFamily>? dependencies,
    required Iterable<ProviderOrFamily>? allTransitiveDependencies,
    required String Function()? debugGetCreateSourceHash,
    Family<Object?>? from,
    Object? argument,
  }) : super(name: name, dependencies: dependencies, allTransitiveDependencies: allTransitiveDependencies, debugGetCreateSourceHash: debugGetCreateSourceHash, from: from, argument: argument);


  /// {@macro riverpod.family}
  static const family = AutoDisposeFutureProviderFamily.new;

  final Create<FutureOr<T>, AutoDisposeFutureProviderRef<T>> _createFn;

  @override
  FutureOr<T> _create(AutoDisposeFutureProviderElement<T> ref) =>
      _createFn(ref);

  @override
  AutoDisposeFutureProviderElement<T> createElement() {
    return AutoDisposeFutureProviderElement._(this);
  }

  @override
  late final Refreshable<Future<T>> future = _future(this);

  /// {@macro riverpod.overridewith}
  Override overrideWith(
    Create<FutureOr<T>, AutoDisposeFutureProviderRef<T>> create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AutoDisposeFutureProvider.internal(
        create,
        from: from,
        argument: argument,
        debugGetCreateSourceHash: null,
        dependencies: null,
        allTransitiveDependencies: null,
        name: null,
      ),
    );
  }
}

/// The [ProviderElementBase] of [AutoDisposeFutureProvider]
class AutoDisposeFutureProviderElement<T> extends FutureProviderElement<T>
    with AutoDisposeProviderElementMixin<AsyncValue<T>>
    implements AutoDisposeFutureProviderRef<T> {
  /// The [ProviderElementBase] for [FutureProvider]
  AutoDisposeFutureProviderElement._(
    AutoDisposeFutureProvider<T> _provider,
  ) : super._(_provider);
}

/// The [Family] of an [AutoDisposeFutureProvider]
class AutoDisposeFutureProviderFamily<R, Arg> extends AutoDisposeFamilyBase<
    AutoDisposeFutureProviderRef<R>,
    AsyncValue<R>,
    Arg,
    FutureOr<R>,
    AutoDisposeFutureProvider<R>> {
  /// The [Family] of an [AutoDisposeFutureProvider]
  AutoDisposeFutureProviderFamily(
    FutureOr<R> Function(AutoDisposeFutureProviderRef<R>, Arg) _createFn, {
    String? name,
    Iterable<ProviderOrFamily>? dependencies,
  }) : super(
    _createFn,
    name: name,
    dependencies: dependencies,
    providerFactory: AutoDisposeFutureProvider.internal,
    allTransitiveDependencies: computeAllTransitiveDependencies(dependencies),
    debugGetCreateSourceHash: null,
  );

  /// Implementation detail of the code-generator.
  @internal
  AutoDisposeFutureProviderFamily.generator(
    FutureOr<R> Function(AutoDisposeFutureProviderRef<R>, Arg) _createFn, {
    required String? name,
    required Iterable<ProviderOrFamily>? dependencies,
    required Set<ProviderOrFamily>? allTransitiveDependencies,
    required String Function()? debugGetCreateSourceHash,
  }) : super(
    _createFn,
    name: name,
    dependencies: dependencies,
    allTransitiveDependencies: allTransitiveDependencies,
    debugGetCreateSourceHash: debugGetCreateSourceHash,
    providerFactory: AutoDisposeFutureProvider<R>.internal,
  );

  /// {@macro riverpod.overridewith}
  Override overrideWith(
    FutureOr<R> Function(AutoDisposeFutureProviderRef<R> ref, Arg arg) create,
  ) {
    return FamilyOverrideImpl<AsyncValue<R>, Arg, AutoDisposeFutureProvider<R>>(
      this,
      (arg) => AutoDisposeFutureProvider<R>.internal(
        (ref) => create(ref, arg),
        from: from,
        argument: arg,
        debugGetCreateSourceHash: null,
        dependencies: null,
        allTransitiveDependencies: null,
        name: null,
      ),
    );
  }
}
