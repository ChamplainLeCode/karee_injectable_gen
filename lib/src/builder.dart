import 'dart:io';

import 'package:build/build.dart';
import 'package:karee_inject/karee_inject.dart';
import 'package:karee_injectable_gen/src/models/constantes.dart'
    show kKareeScreensFile;
import 'package:karee_injectable_gen/src/models/field.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/element.dart';
import 'generators/autowired_generator.dart';
import 'generators/controller_builder.dart';
import 'generators/persistable_generator.dart';
import 'generators/screen_generator.dart';
import 'generators/service_generator.dart';
import 'generators/value_generator.dart';

///
/// This is the builder entry point for @Autowired Annotation
///
Builder autowiredBuilder(BuilderOptions options) =>
    SharedPartBuilder([AutowiredGenerator()], 'autowired',
        formatOutput: buildFormatOutput);

///
/// This is the builder entry point for @Service Annotation
///
Builder serviceBuilder(BuilderOptions options) =>
    SharedPartBuilder([ServiceGenerator()], 'services',
        formatOutput: buildFormatOutput);

///
/// This is the builder entry point for @Controller Annotation
///
Builder controllerBuilder(BuilderOptions options) =>
    SharedPartBuilder([ControllerGenerator()], 'controllers',
        formatOutput: buildFormatOutput);

///
/// This is the builder entry point for @Value Annotation
///
Builder valueBuilder(BuilderOptions options) =>
    SharedPartBuilder([ValueGenerator()], 'values',
        formatOutput: buildFormatOutput);

///
/// This is the builder entry point for @Persistable Annotation
///
Builder persistableBuilder(BuilderOptions options) =>
    SharedPartBuilder([PersistableGenerator()], 'persistable',
        formatOutput: buildFormatOutput);

///
/// This is the builder entry point for @Screen Annotation
///
Builder screenBuilder(BuilderOptions options) {
  ///
  /// in case where no screen has been annotated, we'll create empty file
  ///

  File(kKareeScreensFile).writeAsStringSync('''/// Generated buy Karee\n'''
      '''///\n'''
      '''///Do not modifyn\n\n'''
      '''\tList<Map<Symbol, dynamic>> screens = [\n\n\t];\n''');
  var builder = SharedPartBuilder([ScreenGenerator()], 'screen');
  return builder;
}

///
/// This function does nothing
///
String buildFormatOutput(String typeId) => '''
/// Generated file by KareeInjectableGenerator
/// Start of Injectable

$typeId

/// End of Injectable
''';

///
/// This class is base for model for an annotated class
///
class VisitableElement extends SimpleElementVisitor {
  late DartType className;
  late String uri;
  String? meta;
  List<Field> fields = <Field>[];
  List metaData = [];
  Map<String, dynamic> constructors = {};

  ///
  /// This is an overrided method that help to visit each constructor to read
  /// its parameters
  ///
  @override
  void visitConstructorElement(ConstructorElement element) {
    className = element.type.returnType;
    uri = element.source.uri.toString();
    try {
      meta =
          element.metadata.first.computeConstantValue.call()?.type.toString();
    } catch (e) {
      ;
    }

    metaData = element.metadata
        .map((e) => MapEntry(e.computeConstantValue()?.toStringValue(),
            e.computeConstantValue()?.type))
        .toList();
    element.parameters.forEach((param) {
      var constructor = (constructors[element.displayName] ?? {});
      constructors[element.displayName] = constructor;
      constructors['${param.hashCode}'] = {
        'declaration': {
          'isNamed': param.isNamed,
          'type': param.declaration.type.toString() + '\n',
          'name': param.declaration.name + '\n',
          'kind.name': param.declaration.kind.name + '\n',
          'hasDefaultValue': '${param.declaration.hasDefaultValue}\n',
          'isOptional': '${param.declaration.isOptional}\n',
          'defaultValue': '${param.declaration.defaultValueCode}\n'
        },
        'hasParams':
            param.typeParameters.map((e) => e.runtimeType).toList().toString() +
                '\n',
        'meta': param.metadata
                .map((e) => e.element?.displayName)
                .toList()
                .toString() +
            '\n'
      };
    });
  }

  ///
  /// This is an overrided method that help to visit each field to read
  /// its metadata
  ///
  @override
  void visitFieldElement(FieldElement element) {
    var reflect = element.metadata;
    ElementAnnotation? annotation;

    if (reflect.isNotEmpty) {
      annotation = reflect.firstWhere((element) => true);
    }

    /// Here we need for each field to know whether it is and injectable field
    /// using Autowired, or using Value
    fields.add(Field(
        uri: element.source?.uri.toString() ?? '',
        name: element.name,
        type: element.type.getDisplayString(withNullability: false),
        value: (annotation?.computeConstantValue())
                .toString()
                .contains((Value).toString())
            ? annotation
                ?.computeConstantValue()
                ?.getField('name')
                ?.toStringValue()
            : null,
        injectable: reflect.isNotEmpty
            ? (annotation?.computeConstantValue()?.type ?? '')
                .toString()
                .contains((AutowiredAnnotation).toString())
            : false,
        isPublic: element.isPublic));
  }
}
