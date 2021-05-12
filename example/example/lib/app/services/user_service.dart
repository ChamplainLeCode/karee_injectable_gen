import 'package:example/app/entities/pageable.dart';
import 'package:example/app/services/other_service.dart';
import 'package:example/app/services/parameter_service.dart';
import 'package:karee_inject/karee_inject.dart';
import '../entities/user.dart';

@Service
class UserService {
  @Value('@{server.proxy.url}')
  late final String serverUrl;

  @Value('@{server.proxy.port}')
  late final int port;

  @Value('@{pageable.default.pageSize}')
  late final int pageSize;

  @Value('@{security.authorization.username}')
  late final String username;

  @Value('@{security.authorization.password}')
  late final String password;

  @Autowired
  late final OtherService otherService;

  @Autowired
  late final ParameterService parameterService;

  Future<Page<User>> getUsers([Pageable? pageInfo]) async {
    pageInfo ??= Pageable.fromSize(pageSize);

    /// TODO: fetch data for pageRequest

    return Page.empty();
  }

  void test() {
    print('\n############# other service from userService = $otherService');
  }
}
