import 'package:build/build.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:karee_inject/karee_inject.dart' show AutowiredAnnotation;

/// Generator class for annotation @Autowired
class AutowiredGenerator extends GeneratorForAnnotation<AutowiredAnnotation> {
  @override
  void generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {}
}
