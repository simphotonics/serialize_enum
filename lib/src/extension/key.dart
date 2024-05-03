import 'package:lazy_memo/lazy_memo.dart';

/// Provides the getter [key].
extension Key on Type {
  /// The key used to serialize an object of type `this`.
  String get slowKey {
    final string = toString();
    return string[0].toLowerCase() + string.substring(1);
  }

  /// Memoized function returning the key used to serialize
  /// objects of type `this`.
  static final memo = MemoizedFunction((Type type) {
    final result = type.toString();
    return result[0].toLowerCase() + result.substring(1);
  });

  /// The key used to serialize an object of type `this`.
  String get key => memo(this);
}
