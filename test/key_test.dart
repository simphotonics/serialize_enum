import 'package:serialize_enum/src/extension/json_key.dart';
import 'package:test/test.dart';

void main() {
  group('slow key:', () {
    test('int', () {
      expect((int).slowKey, 'int');
    });
    test('String', () {
      expect((String).slowKey, 'string');
    });
  });
  group('key:', () {
    test('int', () {
      expect((int).key, 'int');
    });
    test('String', () {
      expect((String).key, 'string');
    });
  });
  group('memo:', () {
    test('int', () {
      final key = (num).key;
      expect(JsonKey.memo.functionTable, contains((num)));
      expect(JsonKey.memo.functionTable, containsValue(key));
    });
  });
}
