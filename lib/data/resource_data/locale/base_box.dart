import 'package:hive/hive.dart';

class BaseBox<T> {
  BaseBox(this._boxName, {this.lazy = false});

  final String _boxName;
  final bool lazy;
  late BoxBase<T> _box;

  Future<void> open() async {
    if (!Hive.isBoxOpen(_boxName)) {
      if (lazy) {
        _box = await Hive.openLazyBox<T>(_boxName);
      } else {
        _box = await Hive.openBox<T>(_boxName);
      }
    }
  }

  void clear() => _box.clear();

  void remove(String key) => _box.delete(key);
  Future<void> close() async => _box.close();

  int get length => _box.length;
  bool get isEmpty => _box.isEmpty;
  bool get isNotEmpty => !isEmpty;

  Future<T?> first() async {
    if (_box.isEmpty) {
      return null;
    }
    if (lazy) {
      return (_box as LazyBox<T>?)?.getAt(0);
    } else {
      return (_box as Box<T>?)?.getAt(0);
    }
  }

  Future<void> put(T) async {
    _box.putAt(0, T);
  }

  void operator []=(String key, T value) async => await _box.put(key, value);

}
