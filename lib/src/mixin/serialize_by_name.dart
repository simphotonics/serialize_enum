import 'package:exception_templates/exception_templates.dart';

import '../extension/json_key.dart';

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
  /// import 'package/serialize_enum/serialize_enum.dart';
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
  }) =>
      fromJsonCustomKey(
        json: json,
        values: values,
        key: E.key,
      );

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
  ///   Map<String, dynamic> toJson() => {key: name};
  ///
  ///   /// Reads a json map and returns the corresponding
  ///   /// instance of `AlphabeticOrder`.
  ///   factory AlphabeticOrder.fromJson(Map<String, dynamic> json) =>
  ///   SerializeByName.fromJsonCustomKey(
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
    if (json.containsKey(key) && json[key] is String) {
      return values.firstWhere((e) => e.name == json[key]);
    } else {
      final names = values.map((e) => '\'${e.name}\'').toList();
      throw ExceptionOf<E>(
          message: 'Json validation error',
          expectedState: '{$key: any of $names}',
          invalidState: '$json');
    }
  }
}
