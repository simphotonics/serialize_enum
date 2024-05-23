/// Represents the type Map<String, dynamic>
typedef Json = Map<String, dynamic>;

/// Implemented by a serializable class with a [toJson] method.
abstract interface class Serializable {
  Json toJson();
}
