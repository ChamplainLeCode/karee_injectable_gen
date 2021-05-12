import 'package:example/app/services/user_service.dart';
import 'package:karee_core/karee_core.dart';

@Controller
class UserController {
  @Autowired
  late UserService userService;

  void home(String arg) {
    screen('user_page', RouteMode.PUSH, parameter: arg);
  }

  void filter(String filter) {
    screen('user_filter', RouteMode.NONE, routerName: #userRouter);
  }
}
