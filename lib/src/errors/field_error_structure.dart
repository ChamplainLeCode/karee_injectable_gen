class FieldError implements Exception {
  String field, uri;
  late final String message;
  String? configKey;
  FieldError(this.field, this.uri) {
    message =
        '\nFieldError: Error on field $field, Injectable field cannot be private\n\n>>>> @ $uri\n\n';
  }

  FieldError.badType(this.field, this.configKey, this.uri) {
    message =
        '\nFieldError: Unsupported type for field $field. Cannot Inject config key $configKey\n\n>>>> @ $uri\n\n';
  }

  @override
  String toString() {
    return message;
  }
}
