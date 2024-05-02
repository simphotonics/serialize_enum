import 'package:exception_templates/exception_templates.dart';

/// Interface adding the methods [toJson] and [fromJson] .
abstract interface class SerializableByName {
  /// Converts an enum instance to a map.
  ///
  /// The value must the enum *name*, the key
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
    if (json.containsKey(key) && json[key] is String) {
      return values.firstWhere((e) => e.name == json[key]);
    } else {
      throw ExceptionOf<E>(
          message: 'Json validation error',
          expectedState: '{$key: any of '
              '${values.map((e) => '\'${e.name}\'').toList()}}',
          invalidState: '$json');
    }
  }
}
