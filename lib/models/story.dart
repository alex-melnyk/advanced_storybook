import 'package:flutter/widgets.dart';

/// The story representation class.
class Story {
  const Story({
    required this.path,
    this.description,
    required this.builder,
  });

  /// Story path.
  ///
  /// NOTICE: The '/' character could be used to group,
  /// e.g. 'Common/Button', 'Common/TestField'.
  final String path;

  /// Story description.
  final String? description;

  /// Story widget builder.
  final WidgetBuilder builder;

  /// Section getter.
  String get section {
    final parts = path.split('/');
    return parts.length > 1 ? parts.first : '';
  }

  /// Title getter.
  String get title {
    final parts = path.split('/');
    return parts.length > 1 ? parts.last : path;
  }
}
