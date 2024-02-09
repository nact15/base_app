part of '../core.dart';

extension ListExtension<T> on List<T> {
  T? firstWhereOrNull(bool Function(T) where) {
    for (final element in this) {
      if (where(element)) return element;
    }

    return null;
  }

  T? get firstOrNull {
    if (isNotEmpty) return first;

    return null;
  }

  T? get lastOrNull {
    if (isNotEmpty) return last;

    return null;
  }

  T? elementOrNullAt(int index) {
    if (length > index) {
      return elementAt(index);
    }

    return null;
  }

  void addIfNotNull<E extends T>(E? value) {
    if (value != null) add(value);
  }

  void addAllIfNotNull(List<T?> values) {
    final notNullableValues = <T>[];
    for (final element in values) {
      if (element != null) notNullableValues.add(element);
    }

    if (notNullableValues.isNotEmpty) addAll(notNullableValues);
  }

  List<T> tryGetRange(int start, int end) {
    return end > length ? this : getRange(start, end).toList();
  }

  String getStartsRange(int start) {
    return length > start ? getRange(start, length).join(' ') : '';
  }

  String getEndRange(int end) {
    return length >= end ? getRange(0, end).join(' ') : join(' ');
  }

  List<T> getTryRange(int start, int end) {
    if (length >= end) {
      return getRange(start, end).toList();
    }

    return getRange(start, length).toList();
  }
}

extension AppMapper<T, E> on Iterable<E> {
  Iterable<T> tryMap<T>(T Function(E e) toElement) {
    var countOfErrors = 0;
    final mapped = map((e) {
      try {
        return toElement(e);
      } catch (error, stackTrace) {
        countOfErrors++;
        if (countOfErrors == length) {
          rethrow;
        }
        return null;
      }
    }).whereType<T>();

    return mapped;
  }
}
