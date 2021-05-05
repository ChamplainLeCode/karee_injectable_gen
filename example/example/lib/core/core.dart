import 'package:karee_core/karee_core.dart';

import '../app/app.module.dart';
import '../app/routes/Routes.dart';
import 'core.reflectable.dart';

export 'package:karee_core/karee_core.dart'
    show
        ControllerReflectable,
        ErrorContactAddress,
        KareeConstants,
        KareeMaterialApp,
        KareeRouter,
        Persistable,
        Route,
        Screen,
        Value,
        Autowired,
        Controller,
        Service,
        doRouting,
        screen,
        subscribeController,
        subscribeScreen,
        KareeInstanceProfile,
        RouteMode;

///
/// by Champlain Marius Bakop
///
/// email champlainmarius20@gmail.com
///
/// github ChamplainLeCode
///
///

void initControllerReflectable() {
  ///
  /// Here we subscribe controllers
  ///

  controllers.forEach(subscribeController);
  screens.forEach(subscribeScreen);
}

void initCore() {
  print('Initialisation started');
  initializeReflectable();
  registeredRoute();
  initControllerReflectable();

  print('Initialisation ended');
}

void main() {}
