// ignore_for_file: invalid_use_of_internal_member

part of '../change_notifier_provider.dart';

/// {@macro riverpod.providerrefbase}
abstract class AutoDisposeChangeNotifierProviderRef<
        NotifierT extends ChangeNotifier?>
    extends ChangeNotifierProviderRef<NotifierT>
    implements AutoDisposeRef<NotifierT> {}

// ignore: subtype_of_sealed_class
/// {@macro riverpod.ChangeNotifierprovider}
class AutoDisposeChangeNotifierProvider<NotifierT extends ChangeNotifier?>
    extends _ChangeNotifierProviderBase<NotifierT> {
  /// {@macro riverpod.ChangeNotifierprovider}
  AutoDisposeChangeNotifierProvider(
    this._createFn, {
    String? name,
    Iterable<ProviderOrFamily>? dependencies,
    @Deprecated('Will be removed in 3.0.0') Family<Object?>? from,
    @Deprecated('Will be removed in 3.0.0') Object? argument,
    @Deprecated('Will be removed in 3.0.0') String Function()? debugGetCreateSourceHash,
  }) : super(name: name,
    dependencies: dependencies,
    from: from,
    argument: argument,
    debugGetCreateSourceHash: debugGetCreateSourceHash,
    allTransitiveDependencies: computeAllTransitiveDependencies(dependencies),
  );

  /// An implementation detail of Riverpod
  @internal
  AutoDisposeChangeNotifierProvider.internal(
    this._createFn, {
    required String? name,
    required Iterable<ProviderOrFamily>? dependencies,
    required Iterable<ProviderOrFamily>? allTransitiveDependencies,
    required String Function()? debugGetCreateSourceHash,
    Family<Object?>? from,
    Object? argument,
  }) : super(name: name, dependencies: dependencies, allTransitiveDependencies: allTransitiveDependencies, debugGetCreateSourceHash: debugGetCreateSourceHash, from: from, argument: argument);

  /// {@macro riverpod.family}
  static const family = AutoDisposeChangeNotifierProviderFamily.new;

  final NotifierT Function(AutoDisposeChangeNotifierProviderRef<NotifierT> ref)
      _createFn;

  @override
  NotifierT _create(AutoDisposeChangeNotifierProviderElement<NotifierT> ref) {
    return _createFn(ref);
  }

  @override
  AutoDisposeChangeNotifierProviderElement<NotifierT> createElement() {
    return AutoDisposeChangeNotifierProviderElement<NotifierT>._(this);
  }

  @override
  late final Refreshable<NotifierT> notifier = _notifier<NotifierT>(this);

  /// {@macro riverpod.overridewith}
  Override overrideWith(
    Create<NotifierT, AutoDisposeChangeNotifierProviderRef<NotifierT>> create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AutoDisposeChangeNotifierProvider<NotifierT>.internal(
        create,
        from: from,
        argument: argument,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
      ),
    );
  }
}

/// The element of [AutoDisposeChangeNotifierProvider].
class AutoDisposeChangeNotifierProviderElement<
        NotifierT extends ChangeNotifier?>
    extends ChangeNotifierProviderElement<NotifierT>
    with AutoDisposeProviderElementMixin<NotifierT>
    implements AutoDisposeChangeNotifierProviderRef<NotifierT> {
  /// The [ProviderElementBase] for [ChangeNotifier]
  AutoDisposeChangeNotifierProviderElement._(
    AutoDisposeChangeNotifierProvider<NotifierT> _provider,
  ) : super._(_provider);
}

// ignore: subtype_of_sealed_class
/// The [Family] of [AutoDisposeChangeNotifierProvider].
class AutoDisposeChangeNotifierProviderFamily<NotifierT extends ChangeNotifier?,
        Arg>
    extends AutoDisposeFamilyBase<
        AutoDisposeChangeNotifierProviderRef<NotifierT>,
        NotifierT,
        Arg,
        NotifierT,
        AutoDisposeChangeNotifierProvider<NotifierT>> {
  /// The [Family] of [AutoDisposeChangeNotifierProvider].
  AutoDisposeChangeNotifierProviderFamily(
    NotifierT Function(AutoDisposeChangeNotifierProviderRef<NotifierT>, Arg) _createFn, {
    String? name,
    Iterable<ProviderOrFamily>? dependencies,
  }) : super(
          _createFn,
          name: name,
          dependencies: dependencies,
          providerFactory: AutoDisposeChangeNotifierProvider.internal,
          debugGetCreateSourceHash: null,
          allTransitiveDependencies:
              computeAllTransitiveDependencies(dependencies),
        );

  /// {@macro riverpod.overridewith}
  Override overrideWith(
    NotifierT Function(
      AutoDisposeChangeNotifierProviderRef<NotifierT> ref,
      Arg arg,
    ) create,
  ) {
    return FamilyOverrideImpl<NotifierT, Arg,
        AutoDisposeChangeNotifierProvider<NotifierT>>(
      this,
      (arg) => AutoDisposeChangeNotifierProvider<NotifierT>.internal(
        (ref) => create(ref, arg),
        from: from,
        argument: arg,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
      ),
    );
  }
}
