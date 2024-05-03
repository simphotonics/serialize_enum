import 'package:serialize_enum/src/extension/key.dart';
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
      expect(Key.memo.functionTable, contains((num)));
      expect(Key.memo.functionTable, containsValue(key));
    });
  });
}
