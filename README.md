# Serializable Dart Enums
[![Dart](https://github.com/simphotonics/benchmark_runner/actions/workflows/dart.yml/badge.svg)](https://github.com/simphotonics/benchmark_runner/actions/workflows/dart.yml)


## Introduction

Persisting objects in Dart and Flutter typically consists in
transforming the object into a `Map<String, dynamic>` using a
method called `toJson()`, converting the map into a `String`
using the function [`jsonEncode`][jsonEncode], and
storing the resulting Sting in a file or database.

To revive the object, the stored string is retrieved,
converted back into a `Map<String, dynamic>` using the function
[`jsonDecode`][jsonDecode], and a clone of the original object is generated a factory constructor usually named `.fromJson(Map<String, dynamic> json)`.


Writing the method `toJson()` and the factory constructor `.fromJson`
for a large number of data classes can be tedious and error prone and this task is often acomplished by annotating
data classes and building the source code using packages like:
[`json_serializable`][json_serializable].

The package [`serializable_enum][serializable_enum] provides mixins and interfaces to serialize Dart enums without recourse to
source generation.


## Usage

Include [`serializable_enum`][serializable_enum] as a `dev_dependency`
in your `pubspec.yaml` file.

The example below shows the enum `AlphabeticOrder`. The generic mixin [SerializeByName][SerializeByName] provides the method `toJson`
and the static method `SerializeByName.fromJson`
that is called by the enum factory constructor.

Note: The generic type parameter must be specified since it is used to infer the json map *key* used to store the enum *name*.

```Dart
import 'package:serializable_enum/serializable_enum.dart';

enum AlphabeticOrder with SerializeByName<AlphabeticOrder> {
  asc,
  desc;

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Map<String, dynamic> json) =>
      SerializeByName.fromJson(json: json, values: values);
}

void main() {
  const order = AlphabeticOrder.asc;

  print('Json map:');
  print(order.toJson());

  print('\nRevived enum:');
  print(AlphabeticOrder.fromJson(order.toJson()));
}
```
Running the program above produces the following console output:
```Console
$ dart alphabetic_order_example.dart
Json map:
{alphabeticOrder: asc}

Revived enum:
AlphabeticOrder.asc
```

## Further Serialization Options

To serialize the enum instance by storing its *index* instead of its *name*
one can use the mixin [`SerializeByIndex`][SerializeByIndex].

The interface [`SerializableByName`][`SerializableByName] can be implemented
to serialize an enum by *name* and specify a custom *key*. Note that the
constant *key* must be used in the method `toJson` and passed as parameter to the function `SerializableByName.fromJson`.
```Dart

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
```



## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/simphotonics/serializable_enum/issues

[jsonEncode]: https://api.dart.dev/dart-convert/jsonEncode.html

[jsonDecode]: https://api.dart.dev/dart-convert/jsonDecode.html

[json_serializable]: https://pub.dev/packages/json_serializable

[serializable_enum]: https://pub.dev/packages/serializable_enum

[SerializableByIndex]: https://pub.dev/documentation/serializable_enum/latest/serializable_enum/SerializableByIndex-class.html

[SerializableByName]: https://pub.dev/documentation/serializable_enum/latest/serializable_enum/SerializableByName-class.html

[SerializeByIndex]: https://pub.dev/documentation/serializable_enum/latest/serializable_enum/SerializeByIndex-mixin.html

[SerializeByName]: https://pub.dev/documentation/serializable_enum/latest/serializable_enum/SerializeByName-mixin.html