import 'package:flutter/services.dart';

class Cadastrar {
  static const platform = const MethodChannel("cadastrar");
  Map result = {};
  static Future<void> cadastrar(dados) async {
    platform.invokeMethod('cadastrar', dados).timeout(Duration(seconds: 1));
  }
}
