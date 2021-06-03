import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:karee_inject/karee_inject.dart' show AutowiredAnnotation;

class AutowiredGenerator extends GeneratorForAnnotation<AutowiredAnnotation> {
  @override
  void generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {}
}
