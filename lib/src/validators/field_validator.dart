library karee_generator.validator;

import '../errors/field_error_structure.dart';

import '../models/field.dart';

/// Field Validator
class FieldValidator {
  /// Validate multiple field using [validateField]
  static void validateMultipleFields(List<Field> fields) {
    fields.forEach(validateField);
  }

  /// Validate a field consists to insure that if the field is an injectable
  /// field, it should be public.
  static void validateField(Field field) {
    if (!field.isPublic && (field.injectable || field.value != null)) {
      throw FieldError(field.name, field.uri);
    }
  }
}
