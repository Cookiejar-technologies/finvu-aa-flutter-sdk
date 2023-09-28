part of '../notifier.dart';

/// {@macro riverpod.notifier}
///
/// {@macro riverpod.notifier_provider_modifier}
abstract class FamilyNotifier<State, Arg> extends BuildlessNotifier<State> {
  /// {@template riverpod.notifier.family_arg}
  late final Arg arg;

  @override
  void _setElement(ProviderElementBase<State> element) {
    super._setElement(element);
    arg = element.origin.argument as Arg;
  }

  /// {@macro riverpod.asyncnotifier.build}
  @visibleForOverriding
  State build(Arg arg);
}

/// The provider for [NotifierProviderFamily].
typedef NotifierFamilyProvider<NotifierT extends FamilyNotifier<T, Arg>, T, Arg>
    = FamilyNotifierProviderImpl<NotifierT, T, Arg>;

/// The implementation of [NotifierFamilyProvider] but with loosened type constraints
/// that can be shared with [AutoDisposeNotifierProvider].
///
/// This enables tests to execute on both [NotifierProvider] and
/// [AutoDisposeNotifierProvider] at the same time.
@visibleForTesting
@internal
class FamilyNotifierProviderImpl<NotifierT extends NotifierBase<T>, T, Arg>
    extends NotifierProviderBase<NotifierT, T> with AlwaysAliveProviderBase<T> {
  /// {@macro riverpod.notifier}
  FamilyNotifierProviderImpl(
    NotifierT Function() _createNotifier, {
    String? name,
    Iterable<ProviderOrFamily>? dependencies,
    @Deprecated('Will be removed in 3.0.0') Family<Object?>? from,
    @Deprecated('Will be removed in 3.0.0') Object? argument,
    @Deprecated('Will be removed in 3.0.0') String Function()? debugGetCreateSourceHash,
  }) : super(
    _createNotifier,
    name: name,
    dependencies: dependencies,
    from: from,
    argument: argument,
    debugGetCreateSourceHash: debugGetCreateSourceHash,
    allTransitiveDependencies: computeAllTransitiveDependencies(dependencies),
  );

  /// An implementation detail of Riverpod
  @internal
  FamilyNotifierProviderImpl.internal(
    NotifierT Function() _createNotifier, {
    required String? name,
    required Iterable<ProviderOrFamily>? dependencies,
    required Iterable<ProviderOrFamily>? allTransitiveDependencies,
    required String Function()? debugGetCreateSourceHash,
    Family<Object?>? from,
    Object? argument,
  }) : super(_createNotifier, name: name, dependencies: dependencies, allTransitiveDependencies: allTransitiveDependencies, debugGetCreateSourceHash: debugGetCreateSourceHash, from: from, argument: argument);


  /// {@macro riverpod.autoDispose}
  // ignore: prefer_const_declarations
  static final autoDispose = AutoDisposeNotifierProviderFamily.new;

  // /// {@macro riverpod.family}
  // static const family = NotifierProviderFamilyBuilder();

  @override
  late final AlwaysAliveRefreshable<NotifierT> notifier =
      _notifier<NotifierT, T>(this);

  @override
  NotifierProviderElement<NotifierT, T> createElement() {
    return NotifierProviderElement._(this);
  }

  @override
  T runNotifierBuild(
    covariant FamilyNotifier<T, Arg> notifier,
  ) {
    return notifier.build(notifier.arg);
  }
}

/// The [Family] of [NotifierProvider].
class NotifierProviderFamily<NotifierT extends FamilyNotifier<T, Arg>, T, Arg>
    extends NotifierFamilyBase<NotifierProviderRef<T>, T, Arg, NotifierT,
        NotifierFamilyProvider<NotifierT, T, Arg>> {
  /// The [Family] of [NotifierProvider].
  NotifierProviderFamily(
    NotifierT Function() _createFn, {
    String? name,
    Iterable<ProviderOrFamily>? dependencies,
  }) : super(
    _createFn,
    name: name,
    dependencies: dependencies,
    providerFactory: NotifierFamilyProvider.internal,
    allTransitiveDependencies: computeAllTransitiveDependencies(dependencies),
    debugGetCreateSourceHash: null,
  );

  /// An implementation detail of Riverpod
  @internal
  NotifierProviderFamily.internal(
    NotifierT Function() _createFn, {
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
    providerFactory: NotifierFamilyProvider.internal,
  );

  /// {@macro riverpod.overridewith}
  Override overrideWith(NotifierT Function() create) {
    return FamilyOverrideImpl<T, Arg,
        NotifierFamilyProvider<NotifierT, T, Arg>>(
      this,
      (arg) => NotifierFamilyProvider<NotifierT, T, Arg>.internal(
        create,
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
