import 'package:karee_core/karee_core.dart' show Route;
import 'package:karee_core/karee_core.dart';

/*
 * @Author Champlain Marius Bakop
 * @email champlainmarius20@gmail.com
 * @github ChamplainLeCode
 * 
 */
void registeredRoute() {
  Route.on('/', 'HomeController@index');
  Route.on('/users', 'UserController@home');
  Route.on('/users/admin', 'UserController@filter');
  Route.on('/users/comptable', 'UserController@filter');
  Route.on('/users/dev', 'UserController@filter');
  Route.on('/users/visitor', 'UserController@filter');
  Route.on('/users/enseignant', 'UserController@filter');
  Route.on('/users/cp', 'UserController@filter');
  Route.on('/users/architect', 'UserController@filter');
}
