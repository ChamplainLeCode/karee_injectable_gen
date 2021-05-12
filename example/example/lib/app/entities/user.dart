import 'package:karee_inject/karee_inject.dart' show Persistable;

@Persistable(collection: 'users', serializer: String)
class User {
  double? id;
  String? name;

  @override
  String toString() => {'id': id, 'name': name}.toString();
}
