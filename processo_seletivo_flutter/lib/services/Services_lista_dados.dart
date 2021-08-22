import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

obterlista(http.Client cliente) async {
  var resposta = await cliente.get(
      Uri.parse('http://192.168.100.13:3000/obterlista'),
      headers: {'Content-Type': 'application/json'});
  if (resposta.statusCode == 200) {
    return json.decode(utf8.decode(resposta.body.toString().runes.toList()));
  }
  return null;
}
