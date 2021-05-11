import 'package:example/app/services/user_service.dart';
import 'package:example/core/core.dart';

@Service
class OtherService {
  late final UserService userService;

  OtherService(@Autowired this.userService);

  void test() {
    print('\n~~~~~~~ User service from other = $userService');
  }
}
