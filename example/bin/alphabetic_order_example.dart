import 'package:serialize_enum/serialize_enum.dart';

enum AlphabeticOrder with SerializeByName<AlphabeticOrder> {
  asc,
  desc;

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Json json) =>
      SerializeByName.fromJson(json: json, values: values);
}

void main() {
  const order = AlphabeticOrder.asc;

  print('Json map:');
  print(order.toJson());

  print('\nRevived enum:');
  print(AlphabeticOrder.fromJson(order.toJson()));
}
