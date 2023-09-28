part of '../async_notifier.dart';

/// {@macro riverpod.asyncnotifier}
///
/// {@macro riverpod.async_notifier_provider_modifier}
abstract class FamilyAsyncNotifier<State, Arg>
    extends BuildlessAsyncNotifier<State> {
  /// {@template riverpod.notifier.family_arg}
  /// The argument that was passed to this family.
  ///
  /// For example, when doing:
  ///
  /// ```dart
  /// ref.watch(provider(0));
  /// ```
  ///
  /// then [arg] will be `0`.
  /// {@endtemplate}
  late final Arg arg;

  @override
  void _setElement(ProviderElementBase<AsyncValue<State>> element) {
    super._setElement(element);
    arg = element.origin.argument as Arg;
  }

  /// {@macro riverpod.asyncnotifier.build}
  @visibleForOverriding
  FutureOr<State> build(Arg arg);
}

/// {@macro riverpod.async_notifier_provider}
///
/// {@macro riverpod.async_notifier_provider_modifier}
typedef AsyncNotifierFamilyProvider<
        NotifierT extends FamilyAsyncNotifier<T, Arg>, T, Arg>
    = FamilyAsyncNotifierProviderImpl<NotifierT, T, Arg>;

/// An internal implementation of [AsyncNotifierFamilyProvider] for testing purpose.
///
/// Not meant for public consumption.
@visibleForTesting
@internal
class FamilyAsyncNotifierProviderImpl<NotifierT extends AsyncNotifierBase<T>, T,
        Arg> extends AsyncNotifierProviderBase<NotifierT, T>
    with AlwaysAliveProviderBase<AsyncValue<T>>, AlwaysAliveAsyncSelector<T> {
  /// {@macro riverpod.async_notifier_family_provider}
  FamilyAsyncNotifierProviderImpl(
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
  FamilyAsyncNotifierProviderImpl.internal(
    NotifierT Function() _createNotifier, {
    required String? name,
    required Iterable<ProviderOrFamily>? dependencies,
    required Iterable<ProviderOrFamily>? allTransitiveDependencies,
    required String Function()? debugGetCreateSourceHash,
    Family<Object?>? from,
    Object? argument,
  }) : super(_createNotifier, name: name, dependencies: dependencies, allTransitiveDependencies: allTransitiveDependencies, debugGetCreateSourceHash: debugGetCreateSourceHash, from: from, argument: argument);

  /// {@macro riverpod.autoDispose}
  static const autoDispose = AutoDisposeAsyncNotifierProviderFamily.new;

  @override
  late final AlwaysAliveRefreshable<NotifierT> notifier =
      _asyncNotifier<NotifierT, T>(this);

  @override
  late final AlwaysAliveRefreshable<Future<T>> future = _asyncFuture<T>(this);

  @override
  AsyncNotifierProviderElement<NotifierT, T> createElement() {
    return AsyncNotifierProviderElement._(this);
  }

  @override
  FutureOr<T> runNotifierBuild(
    covariant FamilyAsyncNotifier<T, Arg> notifier,
  ) {
    return notifier.build(notifier.arg);
  }
}

/// The [Family] of [AsyncNotifierProvider].
class AsyncNotifierProviderFamily<NotifierT extends FamilyAsyncNotifier<T, Arg>,
        T, Arg>
    extends NotifierFamilyBase<AsyncNotifierProviderRef<T>, AsyncValue<T>, Arg,
        NotifierT, AsyncNotifierFamilyProvider<NotifierT, T, Arg>> {
  /// The [Family] of [AsyncNotifierProvider].
  AsyncNotifierProviderFamily(
    NotifierT Function() _createFn, {
    String? name,
    Iterable<ProviderOrFamily>? dependencies,
  }) : super(
    _createFn,
    name: name,
    dependencies: dependencies,
    providerFactory: AsyncNotifierFamilyProvider.internal,
    allTransitiveDependencies: computeAllTransitiveDependencies(dependencies),
    debugGetCreateSourceHash: null,
  );

  /// {@macro riverpod.overridewith}
  Override overrideWith(NotifierT Function() create) {
    return FamilyOverrideImpl<AsyncValue<T>, Arg,
        AsyncNotifierFamilyProvider<NotifierT, T, Arg>>(
      this,
      (arg) => AsyncNotifierFamilyProvider<NotifierT, T, Arg>.internal(
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
