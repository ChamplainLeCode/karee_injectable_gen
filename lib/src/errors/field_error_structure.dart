/// class that represent error when handling a field
class FieldError implements Exception {
  /// The name of the field
  String field;
  /// the full path to class that contains the error
  String uri;
  /// The message of this error.
  late final String message;

  /// The config key that we're to read.
  String? configKey;

  /// constructor of the error.
  FieldError(this.field, this.uri) {
    message =
        '\nFieldError: Error on field $field, Injectable field cannot be private\n\n>>>> @ $uri\n\n';
  }

  /// constructor of the error with the configKey.
  FieldError.badType(this.field, this.configKey, this.uri) {
    message =
        '\nFieldError: Unsupported type for field $field. Cannot Inject config key $configKey\n\n>>>> @ $uri\n\n';
  }

  @override
  String toString() {
    return message;
  }
}
