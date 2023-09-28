part of '../provider.dart';

/// {@macro riverpod.providerrefbase}
abstract class AutoDisposeProviderRef<State> extends ProviderRef<State>
    implements AutoDisposeRef<State> {}

/// {@macro riverpod.provider}
class AutoDisposeProvider<T> extends InternalProvider<T> {
  /// {@macro riverpod.provider}
  AutoDisposeProvider(
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
  const AutoDisposeProvider.internal(
    this._createFn, {
    required String? name,
    required Iterable<ProviderOrFamily>? dependencies,
    required Iterable<ProviderOrFamily>? allTransitiveDependencies,
    required String Function()? debugGetCreateSourceHash,
    Family<Object?>? from,
    Object? argument,
  }) : super(name: name, dependencies: dependencies, allTransitiveDependencies: allTransitiveDependencies, debugGetCreateSourceHash: debugGetCreateSourceHash, from: from, argument: argument);


  /// {@macro riverpod.family}
  static const family = AutoDisposeProviderFamily.new;

  final T Function(AutoDisposeProviderRef<T> ref) _createFn;

  @override
  T _create(AutoDisposeProviderElement<T> ref) => _createFn(ref);

  @override
  AutoDisposeProviderElement<T> createElement() {
    return AutoDisposeProviderElement._(this);
  }

  /// {@macro riverpod.overridewith}
  Override overrideWith(
    Create<T, AutoDisposeProviderRef<T>> create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AutoDisposeProvider<T>.internal(
        create,
        from: from,
        argument: argument,
        allTransitiveDependencies: null,
        dependencies: null,
        debugGetCreateSourceHash: null,
        name: null,
      ),
    );
  }
}

/// The element of [AutoDisposeProvider]
class AutoDisposeProviderElement<T> extends ProviderElement<T>
    with AutoDisposeProviderElementMixin<T>
    implements AutoDisposeProviderRef<T> {
  /// The [ProviderElementBase] for [Provider]
  AutoDisposeProviderElement._(AutoDisposeProvider<T> _provider)
      : super._(_provider);
}

/// The [Family] of [AutoDisposeProvider]
class AutoDisposeProviderFamily<R, Arg> extends AutoDisposeFamilyBase<
    AutoDisposeProviderRef<R>, R, Arg, R, AutoDisposeProvider<R>> {
  /// The [Family] of [AutoDisposeProvider]
  AutoDisposeProviderFamily(
    R Function(AutoDisposeProviderRef<R>, Arg)_createFn, {
    String? name,
    Iterable<ProviderOrFamily>? dependencies,
  }) : super(
    _createFn,
    name: name,
    dependencies: dependencies,
    providerFactory: AutoDisposeProvider.internal,
    allTransitiveDependencies: computeAllTransitiveDependencies(dependencies),
    debugGetCreateSourceHash: null,
  );

  /// {@macro riverpod.overridewith}
  Override overrideWith(
    R Function(AutoDisposeProviderRef<R> ref, Arg arg) create,
  ) {
    return FamilyOverrideImpl<R, Arg, AutoDisposeProvider<R>>(
      this,
      (arg) => AutoDisposeProvider<R>.internal(
        (ref) => create(ref, arg),
        from: from,
        argument: arg,
        name: null,
        debugGetCreateSourceHash: null,
        dependencies: null,
        allTransitiveDependencies: null,
      ),
    );
  }
}
