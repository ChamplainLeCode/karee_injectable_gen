import 'package:karee_core/karee_core.dart' show Autowired, Controller, RouteMode, screen;
import '../../services/user_service.dart';

/*
 * @Author Champlain Marius Bakop
 * @email champlainmarius20@gmail.com
 * @github ChamplainLeCode
 * 
 */
@Controller
class HomeController {
  @Autowired
  late UserService userService;

  dynamic index() {
    /// Get the first page of users
    var page = userService.getUsers();
    screen('home', RouteMode.REPLACE, parameter: page);
  }
}
