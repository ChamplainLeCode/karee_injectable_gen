import 'field.dart';

///
/// Service extension model
///
class ServiceExtension {
  ///
  /// Field that represents the class name metadata for classes annotated with
  /// @Service
  ///
  String serviceClassName;

  ///
  /// Field that represents the class uri metadata for classes annotated with
  /// @Service
  ///
  String uri;

  ///
  /// Field that represents the class source file metadata for classes annotated with
  /// @Service
  ///
  String fileName;

  ///
  /// Field that represents the class constructors metadata for classes annotated with
  /// @Service
  ///
  Map<String, dynamic> constructors;

  ///
  /// Field that represents the list of fields of classes annotated with @Service
  ///
  List<Field> fields;

  ServiceExtension({
    required this.serviceClassName,
    required this.fields,
    required this.uri,
    required this.fileName,
    required this.constructors,
  });

  @override
  String toString() {
    return {
      'serviceClassName': serviceClassName,
      'uri': uri,
      'fileName': fileName,
      'fields': fields,
      'constructors': constructors
    }.toString();
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    var test = (other is ServiceExtension) &&
        serviceClassName == other.serviceClassName;
    return test;
  }
}
