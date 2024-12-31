import 'dart:io';

import 'package:build/build.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:karee_injectable_gen/karee_injectable_gen.dart';
import 'package:karee_injectable_gen/src/errors/field_error_structure.dart';
import 'package:karee_injectable_gen/src/models/constantes.dart';
import 'package:karee_injectable_gen/src/models/field.dart';
import 'package:karee_injectable_gen/src/models/service_extension.dart';
import 'package:karee_injectable_gen/src/validators/field_validator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:karee_inject/karee_inject.dart' show ServiceAnnotation;

/// Generator for @Service annotation in Karee
class ServiceGenerator extends GeneratorForAnnotation<ServiceAnnotation> {
  /// Set of know classes metadata annotated with @Service
  Set<ServiceExtension> extensions = {};

  @override
  void generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    var visitor = VisitableElement();
    element.visitChildren(visitor);

    FieldValidator.validateMultipleFields(visitor.fields);

    var ext = ServiceExtension(
        constructors: visitor.constructors,
        fields: visitor.fields,
        fileName: element.source?.shortName ?? '',
        serviceClassName: element.declaration?.name ?? '',
        uri: element.source?.uri
                .toString()
                // We prefer relative path to absolute path, then we replace the
                // package reference with the path to reach [lib/app]
                .replaceAll('package:$applicationName', '') ??
            '');
    writeExtensionIndex(ext);
  }

  /// function used to write extention for this current entry
  void writeExtensionIndex(ServiceExtension ext) {
    if (extensions.where((e) => e == ext).isNotEmpty) {
      return;
    }
    extensions.add(ext);

    var dir = Directory('$kMainExtensionDirPath/$kServiceExtensionDirPath');
    var file = File(kServiceExtensionFilePath);
    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
    }
    if (file.existsSync()) {
      file.deleteSync(recursive: true);
    }
    Directory(kMainExtensionDirPath).createSync(recursive: true);
    Directory('$kMainExtensionDirPath/$kServiceExtensionDirPath')
        .createSync(recursive: true);
    var f = File(kServiceExtensionFilePath);

    var content = '''\n/// Genereated by Karee\n\n\n'''
        '''Map<String, dynamic> serviceExtensions = {\n''';
    var space = 0;
    extensions.forEach((e) {
      content =
          '''import '$kServiceExtensionDirPath/extension_${e.fileName}' as e$space;\n'''
          '''$content'''
          '''\t'${e.serviceClassName}': e$space.\$extended${e.serviceClassName},\n''';
      space++;
    });

    content = '''$content\n};''';
    f.writeAsStringSync(content, mode: FileMode.write);
    extensions.forEach((e) => writeExtentionForService(e));
  }

  /// Function for writing service extension for current abstract service metadata
  void writeExtentionForService(ServiceExtension ext) {
    // print(ext);
    var f = File(
        '$kMainExtensionDirPath/$kServiceExtensionDirPath/extension_${ext.fileName}');

    var content = '''import '${ext.uri}';\n\n'''
        '''/// Generated by Karee \n\n'''
        '''extension ${ext.serviceClassName}Extension on ${ext.serviceClassName} {\n'''
        '''\tstatic late final ${ext.serviceClassName}? service;\n'''
        '''\tstatic bool loaded = false;\n'''
        '''\tvoid init(){''';
    var valueFields = ext.fields
        .where((field) => field.isPublic && (field.value != null))
        .toList();
    if (valueFields.isNotEmpty) {
      content = '''import '$kKareeCorePackage';\n'''
          '''$content''';
    }

    valueFields.forEach((field) {
      content = '''$content'''
          '''\n\t\t${field.name} = ${getInitialValueForField(field)};''';
    });

    /// To avoid cyclic dependency, we set a lock to preserve initialization
    content = '''$content\n'''
        '''\t\t${ext.serviceClassName}Extension.service = this;\n'''
        '''\t\t${ext.serviceClassName}Extension.loaded = true;''';

    /// Because injectable fields through Autowired are only Services, we can
    /// insure that typer of current field will be in `extensions` (ServiceExtension)
    var autowiredFields = ext.fields
        .where((field) => field.isPublic && field.injectable)
        .toList();

    if (autowiredFields.isNotEmpty) {
      content = '''import '../$kServiceExtensionFileName';\n'''
          '''$content''';
    }
    autowiredFields.forEach((field) {
      content = '''$content'''
          '''\n\t\t${field.name} = ${getInitialValueForField(field)};''';
    });

    content = '''$content'''
        '''\n\t}'''
        '''\n\t${ext.serviceClassName} get self {'''
        '''\n\t\tinit();'''
        '''\n\t\treturn this;'''
        '''\n\t}'''
        '''\n}\n\n'''
        '''${ext.serviceClassName} \$extended${ext.serviceClassName}() {\n'''
        '''\tif(!${ext.serviceClassName}Extension.loaded){\n'''
        '''\t\t${ext.serviceClassName}().self;\n'''
        '''\t}'''
        '''\treturn ${ext.serviceClassName}Extension.service!;\n'''
        '''}''';
    f.writeAsStringSync(content, mode: FileMode.write);
  }

  /// function used to get via data type conversion the value when reading the
  /// application config file
  dynamic getInitialValueForField(Field f) {
    if (f.injectable) {
      return "serviceExtensions['${f.type}']()";
    } else if (f.value != null) {
      switch (f.type) {
        case 'int':
        case 'double':
        case 'num':
        case 'String':
        case 'List':
        case 'bool':
          return "readConfig('${f.value}')";
        default:
          if (f.type.startsWith('List<')) {
            return "List.from(readConfig('${f.value}'))";
          }
      }
      throw FieldError.badType(f.name, f.value, f.uri);
    }
  }
}
