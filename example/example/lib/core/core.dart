// import 'package:example/core/extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:karee_core/karee_core.dart';
import '../app/app.module.dart';
import '../app/routes/Routes.dart';
import 'core.reflectable.dart';
import 'package:karee_inject/karee_inject.dart' show subscribeController;

import 'extensions/extensions_controllers.dart';
export 'package:karee_inject/karee_inject.dart' show Value, Screen, Controller, Autowired, Service;
export 'package:karee_core/karee_core.dart'
    show
        subscribeScreen,
        screen,
        ErrorContactAddress,
        KareeConstants,
        KareeMaterialApp,
        KareeRouter,
        Route,
        doRouting,
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

Future<void> initCore() async {
  print('Initialisation started');
  WidgetsFlutterBinding.ensureInitialized();
  initializeReflectable();
  await loadAppConfig();
  registeredRoute();
  initControllerReflectable();
  print('Initialisation ended');
}

void main() async {}
