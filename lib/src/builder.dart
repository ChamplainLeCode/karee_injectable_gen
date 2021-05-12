import 'package:build/build.dart';
import 'package:karee_inject/karee_inject.dart';
import 'package:karee_injectable_gen/src/models/field.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/element.dart';
import 'generators/autowired_generator.dart';
import 'generators/persistable_generator.dart';
import 'generators/screen_generator.dart';
import 'generators/service_generator.dart';
import 'generators/value_generator.dart';

Builder autowiredBuilder(BuilderOptions options) =>
    SharedPartBuilder([AutowiredGenerator()], 'autowired', formatOutput: buildFormatOutput);

Builder serviceBuilder(BuilderOptions options) =>
    SharedPartBuilder([ServiceGenerator()], 'services', formatOutput: buildFormatOutput);

Builder valueBuilder(BuilderOptions options) =>
    SharedPartBuilder([ValueGenerator()], 'values', formatOutput: buildFormatOutput);

Builder persistableBuilder(BuilderOptions options) =>
    SharedPartBuilder([PersistableGenerator()], 'persistable', formatOutput: buildFormatOutput);

Builder screenBuilder(BuilderOptions options) {
  var builder = SharedPartBuilder([ScreenGenerator()], 'screen');
  return builder;
}

String buildFormatOutput(String typeId) => '''
/// Generated file by KareeInjectableGenerator
/// Start of Injectable

$typeId

/// End of Injectable
''';

class VisitableElement extends SimpleElementVisitor {
  late DartType className;
  late String uri;
  late String? meta;
  List<Field> fields = <Field>[];
  List metaData = [];
  Map<String, dynamic> constructors = {};

  @override
  void visitConstructorElement(ConstructorElement element) {
    className = element.type.returnType;
    uri = element.source.uri.toString();
    try {
      meta = element.metadata.first.computeConstantValue.call()?.type.toString();
    } catch (e) {
      ;
    }

    metaData = element.metadata
        .map((e) => MapEntry(e.computeConstantValue()?.toStringValue(), e.computeConstantValue()?.type))
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
        'hisParamss': param.typeParameters.map((e) => e.runtimeType).toList().toString() + '\n',
        'meta': param.metadata.map((e) => e.element?.displayName).toList().toString() + '\n'
      };
    });
  }

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
        value: (annotation?.computeConstantValue()).toString().contains((Value).toString())
            ? annotation?.computeConstantValue()?.getField('name')?.toStringValue()
            : null,
        injectable: reflect.isNotEmpty
            ? (annotation?.computeConstantValue()?.type ?? '').toString().contains((AutowiredAnnotation).toString())
            : false,
        isPublic: element.isPublic));
  }
}
