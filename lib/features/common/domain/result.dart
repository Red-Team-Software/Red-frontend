class Result<T> {
  final T? _value;
  final Exception? _error;
  final bool _isSuccess;

  Result._(T? value, Exception? error, bool isSuccess)
      : assert(value != null || error != null,
            'Result value or error must be provided'),
        _value = value,
        _error = error,
        _isSuccess = isSuccess;

  bool isSuccessful() => _isSuccess;

  T getValue() {
    if (!_isSuccess) throw _error!;
    return _value!;
  }

  Exception getError() {
    if (_isSuccess) throw Exception('Result is successful');
    return _error!;
  }

  factory Result.success(T value) => Result._(value, null, true);

  factory Result.makeError(Exception error) => Result._(null, error, false);
}
