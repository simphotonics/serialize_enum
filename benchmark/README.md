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
  factory AlphabeticOrder.fromJson(Json json) =>
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
  Json toJson() => {key: name};

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Json json) =>
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
  factory AlphabeticOrder.fromJson(Json json) =>
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
  Json toJson() => {key: index};

  /// Reads a json map and returns the corresponding
  /// instance of `AlphabeticOrder`.
  factory AlphabeticOrder.fromJson(Json json) =>
      SerializeByIndex.fromJsonCustomKey(json: json, values: values, key: key);
}
```
</details>

## Benchmark Scores

Running the benchmarks produced the following console output:
```python
$ dart run benchmark_runner report
Building package executable...
Built benchmark_runner:benchmark_runner.

Finding benchmark files in benchmark ...
  benchmark/serialize_by_name_benchmark.dart
  benchmark/serialize_by_index_custom_key_benchmark.dart
  benchmark/serialize_by_index_benchmark.dart
  benchmark/serialize_by_name_custom_key_benchmark.dart

$ dart benchmark/serialize_by_index_custom_key_benchmark.dart
  [048ms:091us] AlphabeticOrder with custom key: serialize by index
    mean: 0.39 ± 0.91 us, median: 0.23 ± 0.044 us
    _▉▅▄█▁____________  468  _____
    sample size: 184 (averaged over 224 runs)

  [038ms:355us] AlphabeticOrder with custom key: deserialize by index
    mean: 0.40 ± 1.76 us, median: 0.11 ± 0.025 us
    ▂▄____▂▇▉▄▁_____________  1877  _____
    sample size: 184 (averaged over 223 runs)


$ dart benchmark/serialize_by_name_custom_key_benchmark.dart
  [050ms:182us] AlphabeticOrder with custom key: serialize by name
    mean: 0.27 ± 0.36 us, median: 0.22 ± 0.0085 us
    ______▁▁_▁▉▂________▁____  1512  _____
    sample size: 175 (averaged over 209 runs)

  [057ms:221us] AlphabeticOrder with custom key: deserialize by name
    mean: 0.52 ± 1.77 us, median: 0.24 ± 0.24 us
    ▉█▃▅▂___________  162  _____
    sample size: 157 (averaged over 181 runs)


$ dart benchmark/serialize_by_index_benchmark.dart
  [063ms:199us] AlphabeticOrder with mixin: serialize by index
    mean: 0.54 ± 1.70 us, median: 0.27 ± 0.18 us
    ▉▂_▂_____________  222  _____
    sample size: 161 (averaged over 188 runs)

  [020ms:273us] AlphabeticOrder with mixin: deserialize by index
    mean: 0.100 ± 0.012 us, median: 0.098 ± 0.0040 us
    _______▄▁▁▉▆▃▂____________  55  _____
    sample size: 195 (averaged over 241 runs)


$ dart benchmark/serialize_by_name_benchmark.dart
  [059ms:219us] AlphabeticOrder with mixin: serialize by name
    mean: 0.47 ± 1.51 us, median: 0.27 ± 0.057 us
    ▂▉▂▄▂____________  705  _____
    sample size: 167 (averaged over 197 runs)

  [046ms:922us] AlphabeticOrder with mixin: deserialize by name
    mean: 0.21 ± 0.19 us, median: 0.13 ± 0.068 us
    ▉__▂____________________________________
    sample size: 159 (averaged over 184 runs)


-------      Summary     --------
Total run time: [02s:649ms]
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