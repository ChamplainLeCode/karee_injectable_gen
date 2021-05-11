import 'field.dart';

class ServiceExtension {
  String serviceClassName;
  String uri;
  String fileName;

  List<Field> fields;

  ServiceExtension({
    required this.serviceClassName,
    required this.fields,
    required this.uri,
    required this.fileName,
  });

  @override
  String toString() {
    return {'serviceClassName': serviceClassName, 'uri': uri, 'fileName': fileName, 'fields': fields}.toString();
  }
}
