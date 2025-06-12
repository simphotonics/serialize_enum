// ignore_for_file: unused_local_variable

import 'package:serialize_enum/serialize_enum.dart';
import 'package:test/test.dart';

enum AlphabeticOrder implements SerializeByName {
  asc,
  desc;

  static const key = 'customKey';

  @override
  Json toJson() => {key: name};

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Json json) =>
      SerializeByName.fromJsonCustomKey(json: json, values: values, key: key);
}

void main() {
  group('AlphabeticOrder with interface:', () {
    test('serialize by name', () {
      expect(AlphabeticOrder.desc.toJson(), {AlphabeticOrder.key: 'desc'});
    });
    test('deserialize by name', () {
      final json = AlphabeticOrder.asc.toJson();
      expect(AlphabeticOrder.fromJson(json), AlphabeticOrder.asc);
    });
  });
}
