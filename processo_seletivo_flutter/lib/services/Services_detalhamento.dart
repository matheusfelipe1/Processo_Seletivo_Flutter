import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<String> obterDetalhamento(http.Client cliente,
    {final String dataParaEnvio}) async {
  Map params = {'data': dataParaEnvio};
  var _body = json.encode(params);
  var resposta = await cliente.post(
      Uri.parse('http://192.168.100.13:3000/obterdadosmedia'),
      headers: {'Content-Type': 'application/json'},
      body: _body);
  if (resposta.statusCode == 200) {
    return utf8.decode(resposta.body.runes.toList());
  }
  return null;
}
