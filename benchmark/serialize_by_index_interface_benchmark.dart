// ignore_for_file: unused_local_variable

import 'package:benchmark_runner/benchmark_runner.dart';
import 'package:serialize_enum/serialize_enum.dart';

enum AlphabeticOrder implements SerializeByIndex {
  asc,
  desc;

  static const key = 'alphabeticOrder';

  @override
  Map<String, dynamic> toJson() => {key: index};

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Map<String, dynamic> json) =>
      SerializeByIndex.fromJsonCustomKey(json: json, values: values, key: key);
}

final order = AlphabeticOrder.desc;
final json = order.toJson();

void main(List<String> args) {
  group('AlphabeticOrder with interface:', () {
    benchmark('serialize by index', () {
      final json = order.toJson();
    });
    benchmark('deserialize by index', () {
      final clone = AlphabeticOrder.fromJson(json);
    });
  });
}
