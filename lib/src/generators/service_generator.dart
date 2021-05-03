import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:karee_injectable_gen/karee_injectable_gen.dart';
import 'package:source_gen/source_gen.dart';
import 'package:karee_inject/karee_inject.dart' show Service;
import '../builder.dart' show VisitableElement;

class ServiceGenerator extends GeneratorForAnnotation<Service> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    print('\n\n\n#### GENERATOR FOR SERVICE ----- begin\n\n\n');
    print({
      'element': {
        'declaration': {
          'displayName':
              element.declaration.getDisplayString(withNullability: true),
          'name': element.declaration.name,
          'type': element.declaration.runtimeType.toString()
        },
        'source_name': element.source?.fullName,
        'uri': element.source?.uri?.toString(),
        'shortname': element.source?.shortName
      }
    });

    var visitor = VisitableElement();
    element.visitChildren(visitor);
    var p = '''
      // ${visitor.className}
      // ${visitor.metaData}
      // ${visitor.fields}
      // ${visitor.metaData}
      // Construtors
      // ${visitor.constructors}
    ''';
    print('\n\n\n#### GENERATOR FOR SERVICE ----- end\n\n\n');
    return p;
  }
}
