// ignore_for_file: unused_local_variable

import 'package:serializable_enum/serializable_enum.dart';
import 'package:test/test.dart';

enum AlphabeticOrder implements SerializableByName {
  asc,
  desc;

  static const key = 'alphabeticOrder';

  @override
  Map<String, dynamic> toJson() => {key: name};

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Map<String, dynamic> json) =>
      SerializableByName.fromJson(json: json, values: values, key: key);
}

void main() {
  group('AlphabeticOrder with interface:', () {
    test('serialize by name', () {
      expect(AlphabeticOrder.desc.toJson(), {'alphabeticOrder': 'desc'});
    });
    test('deserialize by name', () {
      final json = AlphabeticOrder.asc.toJson();
      expect(AlphabeticOrder.fromJson(json), AlphabeticOrder.asc);
    });
  });
}
