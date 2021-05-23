library karee.screen.generator;

import 'dart:io';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:karee_inject/karee_inject.dart';
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
  dynamic generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    var source = element.metadata[0].toSource();

    var annotation = element.metadata.first.computeConstantValue();
    // print('\n######### SCREEN CLASS NAME = "${element.declaration?.name ?? ''}"');
    generatedScreens.putIfAbsent(
        source.substring(source.indexOf('\'') + 1, source.lastIndexOf('\'')),
        () => {
              #uri: element.source?.uri.toString(),
              #className: '${element.declaration?.name ?? ''}()',
              #initial: annotation?.getField('isInitial')?.toBoolValue()
            });
    writeMap();
  }

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

  String underscoreToCambel([String name = '']) {
    var response = '';
    for (var index = 0; index < name.length; index++) {
      var char = name[index];
      char = index == 0 && !isUpper(char) ? char.toUpperCase() : char;
      if (char == '_') {
        response = response + (index + 1 < name.length ? name[index + 1].toUpperCase() : '');
        index++;
      } else {
        response = response + char;
      }
    }
    return response;
  }

  bool isUpper([String char = '']) {
    if (char.isEmpty) return false;
    return char.codeUnitAt(0) >= 65 && char.codeUnitAt(0) <= 90;
  }
}

Map<String, Map<Symbol, dynamic>> generatedScreens = {};

void writeMap() async {
  var f = File('lib/core/screens.dart');
  var content = '''\n\n/// Generated buy Karee\n///\n///Do not modify\n\nList<Map<Symbol, dynamic>> screens = [\n''';
  generatedScreens.forEach((String annotation, Map<Symbol, dynamic> data) {
    if (data[#initial]) {
      content =
          '''import '${data[#uri]}';\n$content\n\t{#name: '$annotation', #screen: () => ${data[#className]}, #initial: ${data[#initial]}},''';
    } else {
      content = '''import '${data[#uri]}';\n$content\n\t{#name: '$annotation', #screen: () => ${data[#className]}},''';
    }
  });
  content = '$content\n\n];';
  await f.writeAsString(content, mode: FileMode.write);
}
