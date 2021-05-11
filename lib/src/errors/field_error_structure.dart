class FieldError implements Exception {
  String field, uri;
  late final String message;
  FieldError(this.field, this.uri) {
    message = '\nFieldError: Error on field $field, Injectable field cannot be private\n\n>>>> @ $uri\n\n';
  }

  @override
  String toString() {
    return message;
  }
}
