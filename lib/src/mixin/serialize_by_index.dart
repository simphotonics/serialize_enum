import 'package:exception_templates/exception_templates.dart';

import '../extension/json_key.dart';

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
  /// import 'package:serialize_enum/serialize_enum.dart';
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
  }) =>
      fromJsonCustomKey(
        json: json,
        values: values,
        key: E.key,
      );

  /// Converts a json map using a custom
  /// enum instance `E`.
  /// ---
  /// Example:
  /// ```
  /// import 'package:serialize_enum/serialize_enum.dart';
  ///
  /// enum AlphabeticOrder implements SerializeByIndex<AlphabeticOrder>{
  ///   asc, desc;
  ///
  ///   const key = 'myCustomKey';
  ///
  ///   @override
  ///   Map<String, dynamic> toJson() => {key: index};
  ///
  ///   /// Reads a json map and returns the corresponding
  ///   /// instance of `AlphabeticOrder`.
  ///   factory AlphabeticOrder.fromJson(Map<String, dynamic> json) =>
  ///   SerializeByIndex.fromJsonCustomKey(
  ///     json: json,
  ///     values: values,
  ///     key: key,
  ///   );
  /// }
  /// ```
  static E fromJsonCustomKey<E extends Enum>({
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
