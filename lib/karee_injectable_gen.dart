/// Support for doing something awesome.
///
/// More dartdocs go here.
library karee_injectable_gen;

import 'dart:convert';
import 'dart:io';

export './src/builder.dart';

///
/// Function used to determine whether the current karee project is a Module
/// or an Application.
///
bool _isModule() {
  var f = File('karee_config.json');

  if (f.existsSync()) {
    var entry = jsonDecode(f.readAsStringSync());
    APPLICATION_NAME = entry['appName'];
    return entry['config']['type'].toString().toLowerCase() == 'module';
  }
  return false;
}

/// Current project name
late String APPLICATION_NAME;

/// Default path to reach where file will be generated.
///
/// In case of an Application, it will be generate under lib/core but in case of
/// module it will be generated under lib/src/core
String GENERATED_SUB_PATH = _isModule() ? '/src/' : '/';
