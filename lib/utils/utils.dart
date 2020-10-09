import 'dart:convert';

String toUtf8(String original) {
  try {
    return utf8.decode(original.codeUnits);
  } catch (ex) {
    return '';
  }
}
