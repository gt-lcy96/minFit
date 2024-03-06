import 'dart:convert';

void prettyPrintJson(Object jsonObject, {String prefix = ''}) {
  var encoder = const JsonEncoder.withIndent('  ');
  String prettyString = encoder.convert(jsonObject);
  print("${prefix}:  ${prettyString}");
} 