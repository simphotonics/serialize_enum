// ignore_for_file: unused_local_variable
import 'package:serializable_enum/serializable_enum.dart';
import 'package:test/test.dart';

enum AlphabeticOrder implements SerializableByIndex {
  asc,
  desc;

  static const key = 'alphabeticOrder';

  @override
  Map<String, dynamic> toJson() => {key: index};

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Map<String, dynamic> json) =>
      SerializableByIndex.fromJson(json: json, values: values, key: key);
}

void main() {
  group('AlphabeticOrder with interface:', () {
    test('serialize by index', () {
      expect(AlphabeticOrder.desc.toJson(), {'alphabeticOrder': 1});
    });
    test('deserialize by index', () {
      final json = AlphabeticOrder.asc.toJson();
      expect(AlphabeticOrder.fromJson(json), AlphabeticOrder.asc);
    });
  });
}
