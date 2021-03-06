import 'field.dart';

class ServiceExtension {
  String serviceClassName;
  String uri;
  String fileName;
  Map<String, dynamic> constructors;
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
  bool operator ==(Object other) {
    var test = (other is ServiceExtension) && serviceClassName == other.serviceClassName;
    // print('Comparing \n\t<[$this]>\n##### TO ###\n\t<[$other]>\n\tResult = $test');
    return test;
  }
}
