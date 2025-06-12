# Serialize Dart Enumerations  - Example
[![Dart](https://github.com/simphotonics/serialize_enum/actions/workflows/dart.yml/badge.svg)](https://github.com/simphotonics/serialize_enum/actions/workflows/dart.yml)


## Example

The example below shows the enum `AlphabeticOrder`. The generic mixin [SerializeByName][SerializeByName] provides the method `toJson`. The enum factory constructor
calls the static method `SerializeByName.fromJson` provided by the mixin:

```Dart
import 'package:serialize_enum/serialize_enum.dart';

enum AlphabeticOrder with SerializeByName<AlphabeticOrder> {
  asc,
  desc;

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Json json) =>
      SerializeByName.fromJson(json: json, values: values);
}
```

Note: The generic type parameter of [SerializeByName][SerializeByName]
must be specified. It is used to generate the json map
*key* under which the enum *name* is stored.

```Dart
// Code shown above goes here ...
void main() {
  const order = AlphabeticOrder.asc;

  print('Json map:');
  print(order.toJson());

  print('\nRevived enum:');
  print(AlphabeticOrder.fromJson(order.toJson()));
}
```
Running the program produces the following console output:
```Console
$ dart alphabetic_order_example.dart
Json map:
{alphabeticOrder: asc}

Revived enum:
AlphabeticOrder.asc
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/simphotonics/serialize_enum/issues

[jsonEncode]: https://api.dart.dev/dart-convert/jsonEncode.html

[jsonDecode]: https://api.dart.dev/dart-convert/jsonDecode.html

[json_serializable]: https://pub.dev/packages/json_serializable

[serialize_enum]: https://pub.dev/packages/serialize_enum

[SerializableByIndex]: https://pub.dev/documentation/serialize_enum/latest/serialize_enum/SerializableByIndex-class.html

[SerializableByName]: https://pub.dev/documentation/serialize_enum/latest/serialize_enum/SerializableByName-class.html

[SerializeByIndex]: https://pub.dev/documentation/serialize_enum/latest/serialize_enum/SerializeByIndex-mixin.html

[SerializeByName]: https://pub.dev/documentation/serialize_enum/latest/serialize_enum/SerializeByName-mixin.html