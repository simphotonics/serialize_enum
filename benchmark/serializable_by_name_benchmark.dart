// ignore_for_file: unused_local_variable

import 'package:benchmark_runner/benchmark_runner.dart';
import 'package:serializable_enum/serializable_enum.dart';

enum AlphabeticOrder implements SerializableByName {
  asc,
  desc;

  static const key = 'alphabeticOrder';

  @override
  Map<String, dynamic> toJson() => {key: name};

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Map<String, dynamic> json) =>
      SerializableByName.fromJson(json: json, values: values, key: key);
}

final order = AlphabeticOrder.desc;
final json = order.toJson();

void main(List<String> args) {
  group('AlphabeticOrder with interface:', () {
    benchmark('serialize by name', () {
      final json = order.toJson();
    });
    benchmark('deserialize by name', () {
      final clone = AlphabeticOrder.fromJson(json);
    });
  });
}
