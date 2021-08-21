import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

obterGrafico(http.Client cliente,
    {required final String dataParaCalculoMedia,
    required final String dataHoje}) async {
  Map params = {'dataHoje': dataHoje, "dataParaCalculo": dataParaCalculoMedia};
  var _body = json.encode(params);
  var resposta = await cliente.post(
      Uri.parse('http://192.168.100.13:3000/obtermedia'),
      headers: {'Content-Type': 'application/json'},
      body: _body);
  print(resposta.body);
  return json.decode(utf8.decode(resposta.body.toString().runes.toList()));
}
