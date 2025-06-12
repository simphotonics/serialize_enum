/// Represents the type `Map<String, Object?>`.
typedef Json = Map<String, Object?>;

/// Implemented by a serializable class with a [toJson] method.
abstract interface class Serializable {
  Json toJson();
}
