import 'package:build/build.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:karee_inject/karee_inject.dart' show Persistable;

/// This class is not supported yet
class PersistableGenerator extends GeneratorForAnnotation<Persistable> {
  @override
  void generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    // print('########### GENERATOR FOR PERSISTABLE ###########@');
  }
}
