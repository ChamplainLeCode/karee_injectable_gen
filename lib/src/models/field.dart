class Field {
  String name;
  bool isPublic;
  String type;
  bool injectable;
  String? value;
  String uri;

  Field(
      {required this.name,
      required this.uri,
      required this.type,
      required this.value,
      required this.injectable,
      required this.isPublic});

  @override
  String toString() => {name, type, value, uri, injectable, isPublic}.toString();
}
