import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:karee_inject/karee_inject.dart' show Persistable;

class PersistableGenerator extends GeneratorForAnnotation<Persistable> {
  @override
  void generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    // print('########### GENERATOR FOR PERSISTABLE ###########@');
  }
}
