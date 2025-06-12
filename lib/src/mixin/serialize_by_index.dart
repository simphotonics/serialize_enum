import 'package:exception_templates/exception_templates.dart';

import '../extension/json_key.dart';
import '../interface/serializable.dart';

/// Provides the methods [toJson] and [fromJson].
mixin SerializeByIndex<T extends Enum> on Enum implements Serializable {
  /// Returns a json map representing the enum instance.
  /// The value represents the enum *index*.
  @override
  Json toJson() => {T.key: index};

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
  ///   factory AlphabeticOrder.fromJson(Json json) =>
  ///   SerializeByIndex.fromJson(json: json, values: values);
  /// }
  /// ```
  static E fromJson<E extends Enum>({
    required Json json,
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
  ///   Map<String, Object?> toJson() => {key: index};
  ///
  ///   /// Reads a json map and returns the corresponding
  ///   /// instance of `AlphabeticOrder`.
  ///   factory AlphabeticOrder.fromJson(Json json) =>
  ///   SerializeByIndex.fromJsonCustomKey(
  ///     json: json,
  ///     values: values,
  ///     key: key,
  ///   );
  /// }
  /// ```
  static E fromJsonCustomKey<E extends Enum>({
    required Json json,
    required List<E> values,
    required String key,
  }) {
    switch (json[key]) {
      case int index when index >= 0 && index < values.length:
        return values[index];
      default:
        throw ExceptionOf<E>(
            message: 'Json validation error',
            expectedState: '{$key: a valid index '
                'between 0 and ${values.length - 1}}',
            invalidState: '$json');
    }
  }
}
