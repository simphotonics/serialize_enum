import 'package:exception_templates/exception_templates.dart';

/// Interface adding the methods [toJson] and [fromJson].
abstract interface class SerializableByIndex {
  /// Converts an enum instance to a map.
  ///
  /// The value must the enum *index*, the key
  /// is arbitray but the same key should be used
  /// in the factory constructor calling the method
  /// `fromJson`
  Map<String, dynamic> toJson();

  /// Converts a map to an enum instance.
  /// * `values`: A list containing the enum values
  ///    associated with a Dart enum.
  /// * `key`: The key used to generate the json map.
  static E fromJson<E extends Enum>({
    required Map<String, dynamic> json,
    required List<E> values,
    required String key,
  }) {
    if (json.containsKey(key) &&
        json[key] is int &&
        json[key] < values.length &&
        json[key] >= 0) {
      return values[json[key]];
    } else {
      throw ExceptionOf<E>(
          message: 'Json validation error',
          expectedState: '{$key: a valid index '
              'between 0 and ${values.length - 1}}',
          invalidState: '$json');
    }
  }
}
