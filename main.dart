class CachedValueProvider {
  late final _cache = _computeValue();
  int get value => _cache;

  int _computeValue() {
    print('In _computeValue...'); // 3
    return 3;
  }
}

void main() {
  print('Calling constructor...'); // 1
  var provider = CachedValueProvider();
  print('Getting value...'); // 2
  print('The value is ${provider.value}!'); // 4
}

/// Output
// Calling constructor...
// Getting value...
// In _computeValue...
// The value is 3!