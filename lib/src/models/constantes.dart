import 'package:karee_injectable_gen/karee_injectable_gen.dart'
    show generatedSubPath;

///
/// constant for extensions base dir
///
final String kMainExtensionDirPath = 'lib${generatedSubPath}core/extensions';

///
/// constant for general extension file
///
const String kMainExtensionFileName = 'extensions.dart';

///
/// constant that represents the path to the general extension file
///
/// see [kMainExtensionFileName]
///
final String kMainExtensionFilePath =
    'lib${generatedSubPath}core/extensions/$kMainExtensionFileName';

///
/// constant for service extension base file
///
const String kServiceExtensionFileName = 'extensions_services.dart';

///
/// constant for service extension dir
///
const String kServiceExtensionDirPath = 'services';

///
/// constant that represents the path to service extension file
///
final String kServiceExtensionFilePath =
    '$kMainExtensionDirPath/$kServiceExtensionFileName';

///
/// constant for controller extension base dir
///
const String kControllerExtensionDirPath = 'controllers';

///
/// constant for Controller Extension filename
///
const String kControllerExtensionFileName = 'extensions_controllers.dart';

///
/// constant that represent controller extension path
///
final String kControllerExtensionFilePath =
    '$kMainExtensionDirPath/$kControllerExtensionFileName';

///
/// constant for representing the karee core package name
///
const String kKareeCorePackage = 'package:karee/core.dart';

///
/// constant for default file where screen metadata are generated
///
final String kKareeScreensFile = 'lib${generatedSubPath}core/screens.dart';
