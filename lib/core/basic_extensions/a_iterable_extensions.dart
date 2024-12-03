extension IterableExt<E> on Iterable<E> {
  Iterable<T> mapNotNull<T>(T? Function(E e) transform) => expand((el) {
        final T? v = transform(el);
        return v == null ? [] : [v];
      });
}
