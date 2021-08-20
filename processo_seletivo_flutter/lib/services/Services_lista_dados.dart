import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<Null> obterlista(http.Client cliente) async {
  await cliente.get(Uri.parse('http://192.168.100.13:3000/obterlista'),
      headers: {
        'Content-Type': 'application/json'
      }).then((value) => {print(value.body)});
}
