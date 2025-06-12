// ignore_for_file: unused_local_variable

import 'package:serialize_enum/serialize_enum.dart';
import 'package:test/test.dart';

enum AlphabeticOrder with SerializeByName<AlphabeticOrder> {
  asc,
  desc;

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Json json) =>
      SerializeByName.fromJson(json: json, values: values);
}

void main() {
  group('AlphabeticOrder with mixin:', () {
    test('serialize by name', () {
      expect(AlphabeticOrder.desc.toJson(), {'alphabeticOrder': 'desc'});
    });
    test('deserialize by name', () {
      final json = AlphabeticOrder.asc.toJson();
      expect(AlphabeticOrder.fromJson(json), AlphabeticOrder.asc);
    });
  });
}
