import 'package:flutter/widgets.dart';

/// Story representation class.
class Story {
  const Story({
    required this.key,
    this.description,
    required this.builder,
  });

  /// Key delimiter string.
  static const keyDelimiter = '/';

  /// Story path.
  ///
  /// NOTICE: The '/' character could be used to group,
  /// e.g. 'Common/Button', 'Common/TestField'.
  final String key;

  /// Story description.
  final String? description;

  /// Story widget builder.
  final WidgetBuilder builder;

  /// Section getter.
  String get section {
    if (key.contains(keyDelimiter)) {
      final index = key.indexOf(keyDelimiter);

      if (index + 1 != key.length) {
        return key.substring(0, index);
      }
    }

    return '';
  }

  /// Title getter.
  String get title {
    if (key.contains(keyDelimiter)) {
      final index = key.indexOf(keyDelimiter);

      if (index + 1 != key.length) {
        return key.substring(index + 1);
      }
    }

    return key;
  }
}
