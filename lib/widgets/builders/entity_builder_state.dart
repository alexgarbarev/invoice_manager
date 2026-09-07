class EntityBuilderState<T> {
  final bool _loading;
  final dynamic _error;

  bool get isLoading => _loading;

  bool get isDone => !_loading && _error == null;

  bool get isFailed => _error != null;

  dynamic get error => _error;

  const EntityBuilderState._(this._loading, this._error);

  factory EntityBuilderState.failure(dynamic error) {
    print('EntityBuilderState with error ${error}');
    return EntityBuilderState._(false, error);
  }

  factory EntityBuilderState.done() {
    return EntityBuilderState._(false, null);
  }

  factory EntityBuilderState.loading() {
    return EntityBuilderState._(true, null);
  }
}
