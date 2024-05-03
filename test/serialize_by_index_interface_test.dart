// ignore_for_file: unused_local_variable
import 'package:serialize_enum/serialize_enum.dart';
import 'package:test/test.dart';

enum AlphabeticOrder implements SerializeByIndex {
  asc,
  desc;

  static const key = 'customKey';

  @override
  Map<String, dynamic> toJson() => {key: index};

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Map<String, dynamic> json) =>
      SerializeByIndex.fromJsonCustomKey(json: json, values: values, key: key);
}

void main() {
  group('AlphabeticOrder with interface:', () {
    test('serialize by index', () {
      expect(AlphabeticOrder.desc.toJson(), {AlphabeticOrder.key: 1});
    });
    test('deserialize by index', () {
      final json = AlphabeticOrder.asc.toJson();
      expect(AlphabeticOrder.fromJson(json), AlphabeticOrder.asc);
    });
  });
}
