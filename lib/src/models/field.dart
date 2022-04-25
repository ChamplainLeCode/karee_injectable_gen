///
/// Model use to get metadata on field
///
class Field {
  /// field name
  String name;

  /// Field visibility
  bool isPublic;

  /// Field Data type
  String type;

  /// Whether Field  is injectable via @Autowired
  bool injectable;

  /// Field value
  String? value;

  /// Field uri
  String uri;

  Field(
      {required this.name,
      required this.uri,
      required this.type,
      required this.value,
      required this.injectable,
      required this.isPublic});

  @override
  String toString() =>
      {name, type, value, uri, injectable, isPublic}.toString();
}
