library karee.screen.generator;

import 'dart:io';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:karee_inject/karee_inject.dart';
import 'package:karee_injectable_gen/karee_injectable_gen.dart'
    show applicationName, generatedSubPath;
import 'package:source_gen/source_gen.dart';

///
/// @Author Champlain Marius Bakop
/// @email champlainmarius20@gmail.com
/// @github ChamplainLeCode
///
///
///ScreenGenerator for Karee core Screen
class ScreenGenerator extends GeneratorForAnnotation<Screen> {
  @override
  dynamic generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    var source = element.metadata[0].toSource();

    var annotation = element.metadata.first.computeConstantValue();
    // print('\n######### SCREEN CLASS NAME = "${element.declaration?.name ?? ''}"');
    generatedScreens.putIfAbsent(
        source.substring(source.indexOf('\'') + 1, source.lastIndexOf('\'')),
        () => {
              #uri: element.source?.uri
                      .toString()
                      // We prefer relative path to absolute path, then we replace the
                      // package reference with the path to reach [lib/app]
                      .replaceAll('package:$applicationName', '') ??
                  '',
              #className: '${element.declaration?.name ?? ''}()',
              #initial: annotation?.getField('isInitial')?.toBoolValue()
            });
    writeMap();
  }

  /// Function that converts string following Underscore notation
  String cambelToUnderscore([String name = '']) {
    var response = '';
    for (var index = 0; index < name.length; index++) {
      var char = name[index];
      if (isUpper(char)) {
        response = response + (index == 0 ? '' : '_') + char.toLowerCase();
      } else {
        response = response + char;
      }
    }
    return response;
  }

  /// Function that converts string following cambel case notation
  String underscoreToCambel([String name = '']) {
    var response = '';
    for (var index = 0; index < name.length; index++) {
      var char = name[index];
      char = index == 0 && !isUpper(char) ? char.toUpperCase() : char;
      if (char == '_') {
        response = response +
            (index + 1 < name.length ? name[index + 1].toUpperCase() : '');
        index++;
      } else {
        response = response + char;
      }
    }
    return response;
  }

  /// Function that determines whether the char passed is an upper case char.
  bool isUpper([String char = '']) {
    if (char.isEmpty) return false;
    return char.codeUnitAt(0) >= 65 && char.codeUnitAt(0) <= 90;
  }
}

/// Math that contains a list of generated String.
Map<String, Map<Symbol, dynamic>> generatedScreens = {};

/// Function that is used to generate metadata for all annotated classes with
/// @Screen
void writeMap() async {
  var f = File('lib${generatedSubPath}core/screens.dart');
  var content =
      '''\n\n/// Generated buy Karee\n///\n///Do not modify\n\nList<Map<Symbol, dynamic>> screens = [\n''';
  generatedScreens.forEach((String annotation, Map<Symbol, dynamic> data) {
    if (data[#initial]) {
      content =
          '''import '${data[#uri]}';\n$content\n\t{#name: '$annotation', #screen: () => ${data[#className]}, #initial: ${data[#initial]}},''';
    } else {
      content =
          '''import '${data[#uri]}';\n$content\n\t{#name: '$annotation', #screen: () => ${data[#className]}},''';
    }
  });
  content = '$content\n\n];';
  await f.writeAsString(content, mode: FileMode.write);
}
