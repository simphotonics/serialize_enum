# Serialize Dart Enums - Benchmark
[![Dart](https://github.com/simphotonics/serialize_enum/actions/workflows/dart.yml/badge.svg)](https://github.com/simphotonics/serialize_enum/actions/workflows/dart.yml)


## Introduction

The benchmark files can be found in the folder [`benchmark`][benchmark].
The benchmarked tasks include serializing and deserializing a Dart enumeration
using:

<details> <summary> the enum name - click to show:  </summary>

```Dart
enum AlphabeticOrder with SerializeByName<AlphabeticOrder> {
  asc,
  desc;

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Map<String, Object?> json) =>
      SerializeByName.fromJson(json: json, values: values);
}
```
</details>
<details> <summary> the enum name and custom json map key - click to show:  </summary>

```Dart
enum AlphabeticOrder implements SerializeByName {
  asc,
  desc;

  static const key = 'alphabeticOrder';

  @override
  Map<String, Object?> toJson() => {key: name};

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Map<String, Object?> json) =>
      SerializeByName.fromJsonCustomKey(json: json, values: values, key: key);
}
```
</details>

<details> <summary> the enum index - click to show:  </summary>

```Dart
enum AlphabeticOrder with SerializeByIndex<AlphabeticOrder> {
  asc,
  desc;

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Map<String, Object?> json) =>
      SerializeByIndex.fromJson(json: json, values: values);
}
```
</details>


<details> <summary> the enum index and a custom json map key
- click to show:  </summary>

```Dart
enum AlphabeticOrder implements SerializeByIndex {
  asc,
  desc;

  static const key = 'alphabeticOrder';

  @override
  Map<String, Object?> toJson() => {key: index};

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Map<String, Object?> json) =>
      SerializeByIndex.fromJsonCustomKey(json: json, values: values, key: key);
}
```
</details>

## Benchmark Scores

Running the benchmarks produced the following console output:
```python
$ dart run benchmark_runner report

Finding benchmark files in benchmark ...
  benchmark/serialize_by_name_benchmark.dart
  benchmark/serialize_by_index_custom_key_benchmark.dart
  benchmark/serialize_by_index_benchmark.dart
  benchmark/serialize_by_name_custom_key_benchmark.dart

$ dart benchmark/serialize_by_index_custom_key_benchmark.dart
  [048ms:331us] AlphabeticOrder with custom key: serialize by index
    mean: 0.28 ± 0.20 us, median: 0.22 ± 0.038 us
    _▄▉▇▂▁____________  105  _____
    sample size: 174 (averaged over 207 runs)

  [014ms:806us] AlphabeticOrder with custom key: deserialize by index
    mean: 0.052 ± 0.0084 us, median: 0.051 ± 0.0030 us
    _______▁▂▄▄▆▉▂____________  59  _____
    sample size: 200 (averaged over 249 runs)


$ dart benchmark/serialize_by_name_benchmark.dart
  [057ms:039us] AlphabeticOrder with mixin: serialize by name
    mean: 0.32 ± 0.19 us, median: 0.27 ± 0.048 us
    _▉▉▇▃▂____________  75  _____
    sample size: 161 (averaged over 188 runs)

  [042ms:403us] AlphabeticOrder with mixin: deserialize by name
    mean: 0.48 ± 1.28 us, median: 0.28 ± 0.15 us
    ▃▉▃▂▂▁____________  221  _____
    sample size: 185 (averaged over 226 runs)


$ dart benchmark/serialize_by_index_benchmark.dart
  [067ms:606us] AlphabeticOrder with mixin: serialize by index
    mean: 0.51 ± 0.99 us, median: 0.29 ± 0.27 us
    ▉▃_▄▁___________  82  _____
    sample size: 157 (averaged over 182 runs)

  [032ms:915us] AlphabeticOrder with mixin: deserialize by index
    mean: 0.16 ± 0.57 us, median: 0.11 ± 0.035 us
    _▃▉█▄▃_▃▂__________  589  _____
    sample size: 177 (averaged over 212 runs)


$ dart benchmark/serialize_by_name_custom_key_benchmark.dart
  [047ms:877us] AlphabeticOrder with custom key: serialize by name
    mean: 0.35 ± 0.79 us, median: 0.23 ± 0.025 us
    __▄▂▃▉▃▁_▁▁_________  873  _____
    sample size: 174 (averaged over 208 runs)

  [057ms:666us] AlphabeticOrder with custom key: deserialize by name
    mean: 0.51 ± 1.29 us, median: 0.41 ± 0.16 us
    ▁▂▉▃█▉▂___________  251  _____
    sample size: 156 (averaged over 179 runs)


-------      Summary     --------
Total run time: [02s:412ms]
Completed benchmarks: 8.
Completed successfully.
Exiting with code: 0.
```

## Conclusion

In principle, it should be faster to serialize an enum using a `const`
custom key. It should also be faster to deserialize an enum using its
*index* compared to using its *name*.

The benchmark scores show that the differences are negligable - at least for
enumerations with few values.


## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/simphotonics/serialize_enum/issues

[benchmark]: https://github.com/simphotonics/serialize_enum/tree/main/benchmark

[jsonEncode]: https://api.dart.dev/dart-convert/jsonEncode.html

[jsonDecode]: https://api.dart.dev/dart-convert/jsonDecode.html

[json_serializable]: https://pub.dev/packages/json_serializable

[serialize_enum]: https://pub.dev/packages/serialize_enum

[SerializableByIndex]: https://pub.dev/documentation/serialize_enum/latest/serialize_enum/SerializableByIndex-class.html

[SerializableByName]: https://pub.dev/documentation/serialize_enum/latest/serialize_enum/SerializableByName-class.html

[SerializeByIndex]: https://pub.dev/documentation/serialize_enum/latest/serialize_enum/SerializeByIndex-mixin.html

[SerializeByName]: https://pub.dev/documentation/serialize_enum/latest/serialize_enum/SerializeByName-mixin.html