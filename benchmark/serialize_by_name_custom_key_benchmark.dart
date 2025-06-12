// ignore_for_file: unused_local_variable

import 'package:benchmark_runner/benchmark_runner.dart';
import 'package:serialize_enum/serialize_enum.dart';

enum AlphabeticOrder implements SerializeByName {
  asc,
  desc;

  static const key = 'alphabeticOrder';

  @override
  Json toJson() => {key: name};

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Json json) =>
      SerializeByName.fromJsonCustomKey(json: json, values: values, key: key);
}

final order = AlphabeticOrder.desc;
final json = order.toJson();

void main(List<String> args) {
  group('AlphabeticOrder with custom key:', () {
    benchmark('serialize by name', () {
      final json = order.toJson();
    });
    benchmark('deserialize by name', () {
      final clone = AlphabeticOrder.fromJson(json);
    });
  });
}
