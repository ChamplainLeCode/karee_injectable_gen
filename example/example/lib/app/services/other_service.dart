import 'package:example/app/services/user_service.dart';
import 'package:example/core/core.dart';

import 'parameter_service.dart';

@Service
class OtherService {
  @Autowired
  late final UserService userService;
  @Autowired
  late final ParameterService parameterService;

  OtherService();

  void test() {
    print('\n~~~~~~~ User service from other = $userService');
  }
}
