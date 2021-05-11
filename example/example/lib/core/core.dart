import 'package:example/core/extensions.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  initializeReflectable();
  loadAppConfig(rootBundle.loadString('resources/config/application.yaml')).then((value) {
    return extensions
      ..forEach((key, value) {
        try {
          print(value().test());
        } catch (e, st) {
          print('#######"" error = $e');
          print(st);
        }
      });
    // ..forEach((key, value) {
    //   try {
    //     print(value().test());
    //   } catch (e) {
    //     print('#######"" error = $e');
    //   }
    // });
  });
  registeredRoute();
  initControllerReflectable();
  print('Initialisation ended');
}

void main() async {}
