import 'package:exception_templates/exception_templates.dart';

import '../extension/json_key.dart';
import '../interface/serializable.dart';

/// Provides the methods [toJson] and [fromJson].
mixin SerializeByName<T extends Enum> on Enum implements Serializable {
  /// Returns a json map representing the enum instance.
  /// The value used is the enum *name*.
  @override
  Json toJson() => {T.key: name};

  /// Converts a json map to the corresponding
  /// enum instance `E`.
  /// ---
  /// Example:
  /// ```
  /// import 'package/serialize_enum/serialize_enum.dart';
  ///
  /// enum AlphabeticOrder with SerializeByName<AlphabeticOrder>{
  ///   asc, desc;
  ///
  ///   /// Reads a json map and returns the corresponding
  ///   /// instance of `AlphabeticOrder`.
  ///   factory AlphabeticOrder.fromJson(Json json) =>
  ///   SerializableEnumMixin.fromJson(json: json, values: values);
  /// }
  /// ```
  static E fromJson<E extends Enum>({
    required Json json,
    required List<E> values,
  }) => fromJsonCustomKey(json: json, values: values, key: E.key);

  /// Converts a json map using a custom *key* to the corresponding
  /// enum instance `E`.
  ///
  /// Usage
  /// ```
  /// import 'package/serialize_enum/serialize_enum.dart';
  ///
  /// enum AlphabeticOrder with SerializeByName<AlphabeticOrder>{
  ///   asc, desc;
  ///
  ///   const key = 'myCustomKey';
  ///
  ///   @override
  ///   Json toJson() => {key: name};
  ///
  ///   /// Reads a json map and returns the corresponding
  ///   /// instance of `AlphabeticOrder`.
  ///   factory AlphabeticOrder.fromJson(Json json) =>
  ///   SerializeByName.fromJsonCustomKey(
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
    if (json.containsKey(key) && json[key] is String) {
      return values.firstWhere((e) => e.name == json[key]);
    } else {
      final names = values.map((e) => '\'${e.name}\'').toList();
      throw ExceptionOf<E>(
        message: 'Json validation error',
        expectedState: '{$key: any of $names}',
        invalidState: '$json',
      );
    }
  }
}
