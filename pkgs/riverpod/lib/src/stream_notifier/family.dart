part of '../async_notifier.dart';

/// {@macro riverpod.streamNotifier}
abstract class FamilyStreamNotifier<State, Arg>
    extends BuildlessStreamNotifier<State> {
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

  /// {@macro riverpod.StreamNotifier.build}
  @visibleForOverriding
  Stream<State> build(Arg arg);
}

/// {@macro riverpod.streamNotifier}
typedef StreamNotifierFamilyProvider<
        NotifierT extends FamilyStreamNotifier<T, Arg>, T, Arg>
    = FamilyStreamNotifierProviderImpl<NotifierT, T, Arg>;

/// An internal implementation of [StreamNotifierFamilyProvider] for testing purpose.
///
/// Not meant for public consumption.
@visibleForTesting
@internal
class FamilyStreamNotifierProviderImpl<NotifierT extends AsyncNotifierBase<T>,
        T, Arg> extends StreamNotifierProviderBase<NotifierT, T>
    with AlwaysAliveProviderBase<AsyncValue<T>>, AlwaysAliveAsyncSelector<T> {
  /// {@macro riverpod.streamNotifier}
  FamilyStreamNotifierProviderImpl(
    NotifierT Function() _createNotifier, {
    String? name,
    Iterable<ProviderOrFamily>? dependencies,
  }) : super(
    _createNotifier,
    name: name,
    dependencies: dependencies,
    allTransitiveDependencies: computeAllTransitiveDependencies(dependencies),
    from: null,
    argument: null,
    debugGetCreateSourceHash: null,
  );

  /// An implementation detail of Riverpod
  @internal
  FamilyStreamNotifierProviderImpl.internal(
    NotifierT Function() _createNotifier, {
    required String? name,
    required Iterable<ProviderOrFamily>? dependencies,
    required Iterable<ProviderOrFamily>? allTransitiveDependencies,
    required String Function()? debugGetCreateSourceHash,
    Family<Object?>? from,
    Object? argument,
  }) : super(_createNotifier, name: name, dependencies: dependencies, allTransitiveDependencies: allTransitiveDependencies, debugGetCreateSourceHash: debugGetCreateSourceHash, from: from, argument: argument);


  /// {@macro riverpod.autoDispose}
  static const autoDispose = AutoDisposeStreamNotifierProviderFamily.new;

  @override
  late final AlwaysAliveRefreshable<NotifierT> notifier =
      _streamNotifier<NotifierT, T>(this);

  @override
  late final AlwaysAliveRefreshable<Future<T>> future = _streamFuture<T>(this);

  @override
  StreamNotifierProviderElement<NotifierT, T> createElement() {
    return StreamNotifierProviderElement._(this);
  }

  @override
  Stream<T> runNotifierBuild(
    covariant FamilyStreamNotifier<T, Arg> notifier,
  ) {
    return notifier.build(notifier.arg);
  }
}

/// The [Family] of [StreamNotifierProvider].
class StreamNotifierProviderFamily<
        NotifierT extends FamilyStreamNotifier<T, Arg>, T, Arg>
    extends NotifierFamilyBase<StreamNotifierProviderRef<T>, AsyncValue<T>, Arg,
        NotifierT, StreamNotifierFamilyProvider<NotifierT, T, Arg>> {
  /// The [Family] of [StreamNotifierProvider].
  StreamNotifierProviderFamily(
    NotifierT Function() _createFn, {
    String? name,
    Iterable<ProviderOrFamily>? dependencies,
  }) : super(
    _createFn,
    name: name,
    dependencies: dependencies,
    providerFactory: StreamNotifierFamilyProvider.internal,
    allTransitiveDependencies: computeAllTransitiveDependencies(dependencies),
    debugGetCreateSourceHash: null,
  );

  /// {@macro riverpod.overridewith}
  Override overrideWith(NotifierT Function() create) {
    return FamilyOverrideImpl<AsyncValue<T>, Arg,
        StreamNotifierFamilyProvider<NotifierT, T, Arg>>(
      this,
      (arg) => StreamNotifierFamilyProvider<NotifierT, T, Arg>.internal(
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
