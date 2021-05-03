import 'package:build/build.dart';
import 'package:karee_inject/karee_inject.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/element.dart';
import 'generators/autowired_generator.dart';
import 'generators/persistable_generator.dart';
import 'generators/service_generator.dart';
import 'generators/value_generator.dart';
import 'dart:mirrors' as r;

Builder autowiredBuilder(BuilderOptions options) =>
    SharedPartBuilder([AutowiredGenerator()], 'autowired',
        formatOutput: buildFormatOutput);

Builder serviceBuilder(BuilderOptions options) =>
    SharedPartBuilder([ServiceGenerator()], 'services',
        formatOutput: buildFormatOutput);

Builder valueBuilder(BuilderOptions options) =>
    SharedPartBuilder([ValueGenerator()], 'values',
        formatOutput: buildFormatOutput);

Builder persistableBuilder(BuilderOptions options) =>
    SharedPartBuilder([PersistableGenerator()], 'persistable',
        formatOutput: buildFormatOutput);

String buildFormatOutput(String typeId) => '''
/// Generated file by KareeInjectableGenerator
/// Start of Injectable

$typeId

/// End of Injectable
''';

class VisitableElement extends SimpleElementVisitor {
  DartType className;
  String uri;
  String meta;
  List<Map<Symbol, Object>> fields = <Map<Symbol, Object>>[];
  List metaData = [];
  Map<String, dynamic> constructors = {};

  @override
  void visitConstructorElement(ConstructorElement element) {
    className = element.type.returnType;
    uri = element.source.uri.toString();
    meta = element.metadata
        .firstWhere((element) => true, orElse: () => null)
        ?.computeConstantValue()
        ?.type
        .toString();
    metaData = element.metadata
        .map((e) => MapEntry(e.computeConstantValue().toStringValue(),
            e.computeConstantValue().type))
        .toList();
    element.parameters.forEach((param) {
      var constructor = (constructors[element.displayName] ?? {});
      constructors[element.displayName] = constructor;
      constructors['${param.hashCode}'] = {
        'declaration': {
          'type': param.declaration.type.toString() + '\n',
          'name': param.declaration.name + '\n',
          'kind.name': param.declaration.kind.name + '\n',
          'hasDefaultValue': '${param.declaration.hasDefaultValue}\n',
          'isOptional': '${param.declaration.isOptional}\n',
          'defaultValue': '${param.declaration.defaultValueCode}\n'
        },
        'hisParams':
            param.typeParameters.map((e) => e.runtimeType).toList().toString() +
                '\n',
        'meta': param.metadata
                .map((e) => e.element.displayName)
                .toList()
                .toString() +
            '\n'
      };
    });
  }

  @override
  void visitFieldElement(FieldElement element) {
    var reflect = element.metadata;
    fields.add({
      #name: element.name,
      #isPublic: element.isPublic,
      #type: element.type.getDisplayString(withNullability: false),
      #injectable: ((reflect
                      .firstWhere((element) => true, orElse: () => null)
                      ?.computeConstantValue())
                  ?.type ??
              '')
          .toString()
          .contains((Autowired).toString())
    });
  }
}
