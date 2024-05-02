// ignore_for_file: unused_local_variable

import 'package:benchmark_runner/benchmark_runner.dart';
import 'package:serializable_enum/serializable_enum.dart';

enum AlphabeticOrder with SerializeByIndex<AlphabeticOrder> {
  asc,
  desc;

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Map<String, dynamic> json) =>
      SerializeByIndex.fromJson(json: json, values: values);
}

final order = AlphabeticOrder.desc;
final json = order.toJson();

void main(List<String> args) {
  group('AlphabeticOrder with mixin:', () {
    benchmark('serialize by index', () {
      final json = order.toJson();
    });
    benchmark('deserialize by index', () {
      final clone = AlphabeticOrder.fromJson(json);
    });
  });
}
