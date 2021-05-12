import 'package:example/app/services/user_service.dart';
import 'package:karee_inject/karee_inject.dart';

import 'other_service.dart';

@Service
class ParameterService {
  @Value('@{security.authorization.authorities}')
  late List<String> roles;

  @Autowired
  late UserService userService;

  @Autowired
  late OtherService otherService;

  void test() {
    print('@@@@@@@@@@@@@@@ Show test from param roles = $roles Services = { other: $otherService, user: $userService}');
  }
}
