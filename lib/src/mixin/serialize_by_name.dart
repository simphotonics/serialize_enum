import 'package:exception_templates/exception_templates.dart';

import '../extension/key.dart';

/// Provides the methods [toJson] and [fromJson].
mixin SerializeByName<T extends Enum> on Enum {
  /// Returns a json map representing the enum instance.
  /// The value used is the enum *name*.
  Map<String, dynamic> toJson() => {T.key: name};

  /// Converts a json map to the corresponding
  /// enum instance `E`.
  /// ---
  /// Example:
  /// ```
  /// import 'package/serializable_enum/serializable_enum.dart';
  ///
  /// enum AlphabeticOrder with SerializeByName<AlphabeticOrder>{
  ///   asc, desc;
  ///
  ///   /// Reads a json map and returns the corresponding
  ///   /// instance of `AlphabeticOrder`.
  ///   factory AlphabeticOrder.fromJson(Map<String, dynamic> json) =>
  ///   SerializableEnumMixin.fromJson(json: json, values: values);
  /// }
  /// ```
  static E fromJson<E extends Enum>({
    required Map<String, dynamic> json,
    required List<E> values,
    //required String key,
  }) {
    final key = E.key;
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
