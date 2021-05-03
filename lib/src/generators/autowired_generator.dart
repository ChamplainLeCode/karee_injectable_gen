import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:karee_inject/karee_inject.dart' show Autowired;

class AutowiredGenerator extends GeneratorForAnnotation<Autowired> {
  @override
  void generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    print('\n\n\n#### GENERATOR FOR AUTOWIRED ----- begin\n\n\n');
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
    print('\n\n\n#### GENERATOR FOR AUTOWIRED ----- end\n\n\n');
  }
}
