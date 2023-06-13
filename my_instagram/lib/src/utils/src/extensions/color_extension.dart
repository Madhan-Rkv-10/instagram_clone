import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

extension AsHtmlColorToCOlor on String {
  Color htmlColorToColor() => Color(
        int.parse(
            removeAll(
              [
                '0x',
                '#',
              ],
            ).padLeft(8, 'ff'),
            radix: 16),
      );
}

extension RmeoveAll on String {
  String removeAll(Iterable<String> values) => values.fold(
        this,
        (result, pattern) => result.replaceAll(
          pattern,
          '',
        ),
      );
}

extension Log on Object {
  void log() => devtools.log(toString());
}

extension DismissKeyboard on Widget {
  void dismissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}
