/// Map [data] with [map] function.
///
/// It will return `null` if [data] is null.
R? orNull<T extends Object, R>({
  required T? data,
  required R Function(T data) map,
}) {
  if (data == null) {
    return null;
  }

  return map(data);
}
