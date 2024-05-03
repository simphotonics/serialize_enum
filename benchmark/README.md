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

Finding benchmark files...
  benchmark/serialize_by_name_benchmark.dart
  benchmark/serialize_by_index_benchmark.dart
  benchmark/serialize_by_name_custom_key_benchmark.dart
  benchmark/serialize_by_index_custom_key_benchmark.dart

Progress timer: [01s:000ms]

Running: dart --define=isBenchmarkProcess=true benchmark/serialize_by_name_custom_key_benchmark.dart
  [216ms:302us] AlphabeticOrder with custom key: serialize by name;
                 mean: 0.48 ± 0.69 us, median: 0.37 ± 0.032 us
                 ▉▁_▂__________  448  _____ sample size: 100 (averaged over 206 runs)

  [215ms:061us] AlphabeticOrder with custom key: deserialize by name;
                mean: 1.21 ± 5.12 us, median: 0.34 ± 0.0030 us
                 _______▉▉▅▂▂_________  34813  _____ sample size: 100 (averaged over 205 runs)




Running: dart --define=isBenchmarkProcess=true benchmark/serialize_by_name_benchmark.dart
  [219ms:585us] AlphabeticOrder with mixin: serialize by name;
                 mean: 0.48 ± 0.25 us, median: 0.41 ± 0.031 us
                 ▉▁▂___________  85  _____ sample size: 100 (averaged over 235 runs)

  [212ms:089us] AlphabeticOrder with mixin: deserialize by name;
                 mean: 0.43 ± 0.28 us, median: 0.40 ± 0.0020 us
                 ▂▇▇▉_█▃_________  3186  _____ sample size: 100 (averaged over 214 runs)




Running: dart --define=isBenchmarkProcess=true benchmark/serialize_by_index_benchmark.dart
  [218ms:215us] AlphabeticOrder with mixin: serialize by index;
                 mean: 0.44 ± 0.12 us, median: 0.41 ± 0.031 us
                 ▉_▁▂__________  61  _____ sample size: 100 (averaged over 222 runs)

  [211ms:567us] AlphabeticOrder with mixin: deserialize by index;
                 mean: 0.49 ± 0.19 us, median: 0.47 ± 0.40 us
                 ▆▅▉▁ sample size: 100 (averaged over 207 runs)




Running: dart --define=isBenchmarkProcess=true benchmark/serialize_by_index_custom_key_benchmark.dart
  [214ms:866us] AlphabeticOrder with custom key: serialize by index;
                mean: 0.39 ± 0.14 us, median: 0.36 ± 0.034 us
                 ▉_▂________________ sample size: 100 (averaged over 215 runs)

  [209ms:815us] AlphabeticOrder with custom key: deserialize by index;
                 mean: 0.27 ± 0.17 us, median: 0.16 ± 0.32 us
                 ▉_▁▂_ sample size: 100 (averaged over 319 runs)


-------      Summary     --------
Total run time: [01s:757ms]
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