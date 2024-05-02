import 'package:exception_templates/exception_templates.dart';

import '../extension/key.dart';

/// Provides the methods [toJson] and [fromJson].
mixin SerializeByIndex<T extends Enum> on Enum {
  /// Returns a json map representing the enum instance.
  /// The value represents the enum *index*.
  Map<String, dynamic> toJson() => {T.key: index};

  /// Converts a json map to the corresponding
  /// enum instance `E`.
  /// ---
  /// Example:
  /// ```
  /// import 'serializable_enum.dart';
  ///
  /// enum AlphabeticOrder with SerializeByIndex<AlphabeticOrder>{
  ///   asc, desc;
  ///
  ///   /// Reads a json map and returns the corresponding
  ///   /// instance of `AlphabeticOrder`.
  ///   factory AlphabeticOrder.fromJson(Map<String, dynamic> json) =>
  ///   SerializeByIndex.fromJson(json: json, values: values);
  /// }
  /// ```
  static E fromJson<E extends Enum>({
    required Map<String, dynamic> json,
    required List<E> values,
  }) {
    final key = E.key;
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
