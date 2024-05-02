// ignore_for_file: unused_local_variable
import 'package:serializable_enum/serializable_enum.dart';
import 'package:test/test.dart';

enum AlphabeticOrder with SerializeByIndex<AlphabeticOrder> {
  asc,
  desc;

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Map<String, dynamic> json) =>
      SerializeByIndex.fromJson(json: json, values: values);
}

void main() {
  group('AlphabeticOrder with mixin:', () {
    test('serialize by index', () {
      expect(AlphabeticOrder.desc.toJson(), {(AlphabeticOrder).key: 1});
    });
    test('deserialize by index', () {
      final json = AlphabeticOrder.asc.toJson();
      expect(AlphabeticOrder.fromJson(json), AlphabeticOrder.asc);
    });
  });
}
