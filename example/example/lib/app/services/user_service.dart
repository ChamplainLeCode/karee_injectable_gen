import 'package:example/app/entities/pageable.dart';
import 'package:karee_inject/karee_inject.dart';
import '../entities/user.dart';

@Service
class UserService {
  @Value('@{server.proxy.url}')
  late String serverUrl;

  @Value('@{pageable.default.pageSize}')
  late final int pageSize;

  Future<Page<User>> getUsers([Pageable? pageInfo]) async {
    pageInfo ??= Pageable.fromSize(pageSize);

    ///
    /// TODOs: Fetch users from within the first page
    ///

    return Page.empty();
  }
}
