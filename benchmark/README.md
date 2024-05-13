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
  factory AlphabeticOrder.fromJson(Map<String, dynamic> json) =>
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
  Map<String, dynamic> toJson() => {key: name};

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Map<String, dynamic> json) =>
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
  factory AlphabeticOrder.fromJson(Map<String, dynamic> json) =>
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
  Map<String, dynamic> toJson() => {key: index};

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Map<String, dynamic> json) =>
      SerializeByIndex.fromJsonCustomKey(json: json, values: values, key: key);
}
```
</details>

## Benchmark Scores

Running the benchmarks produced the following console output:
```python
$ dart run benchmark_runner
Building package executable...
Built benchmark_runner:benchmark_runner.

Finding benchmark files...
  benchmark/serialize_by_name_benchmark.dart
  benchmark/serialize_by_index_benchmark.dart
  benchmark/serialize_by_name_custom_key_benchmark.dart
  benchmark/serialize_by_index_custom_key_benchmark.dart

Progress timer: [01s:000ms]

$ dart benchmark/serialize_by_name_custom_key_benchmark.dart
  [224ms:247us] AlphabeticOrder with custom key: serialize by name
    mean: 1.60 ± 7.59 us, median: 0.38 ± 0.038 us
    __▉▂▄▁__________  3972  _____ sample size: 100 (averaged over 248 runs)

  [232ms:375us] AlphabeticOrder with custom key: deserialize by name
    mean: 3.60 ± 23.30 us, median: 0.35 ± 0.065 us
    _▄▉▂▉▄▁_________  6930  _____ sample size: 100 (averaged over 287 runs)




$ dart benchmark/serialize_by_name_benchmark.dart
  [225ms:140us] AlphabeticOrder with mixin: serialize by name
    mean: 0.94 ± 3.026 us, median: 0.47 ± 0.092 us
    ▁▄▉▆▅▂__________  701  _____ sample size: 100 (averaged over 222 runs)

  [223ms:086us] AlphabeticOrder with mixin: deserialize by name
    mean: 0.82 ± 3.0057 us, median: 0.41 ± 0.087 us
    ___▉_____________  783  _____ sample size: 100 (averaged over 284 runs)




$ dart benchmark/serialize_by_index_custom_key_benchmark.dart
  [232ms:062us] AlphabeticOrder with custom key: serialize by index
    mean: 0.73 ± 1.86 us, median: 0.34 ± 0.067 us
    _▄▉▄▂▁_________  506  _____ sample size: 100 (averaged over 456 runs)

  [215ms:197us] AlphabeticOrder with custom key: deserialize by index
    mean: 0.50 ± 0.24 us, median: 0.48 ± 0.11 us
    __▉▂▆▄__________  31  _____ sample size: 100 (averaged over 194 runs)


Progress timer: [01s:500ms]

$ dart benchmark/serialize_by_index_benchmark.dart
  [257ms:302us] AlphabeticOrder with mixin: serialize by index
    mean: 3.085 ± 15.16 us, median: 0.48 ± 0.051 us
    __▄▆▉▆▃__________  5994  _____ sample size: 100 (averaged over 383 runs)

  [215ms:144us] AlphabeticOrder with mixin: deserialize by index
    mean: 0.35 ± 0.076 us, median: 0.33 ± 0.054 us
    ▄▉▉▃▁_▂▁_______________ sample size: 100 (averaged over 322 runs)


-------      Summary     --------
Total run time: [02s:129ms]
Completed benchmarks: 8.
Completed successfully.
Exiting with code: 0.

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