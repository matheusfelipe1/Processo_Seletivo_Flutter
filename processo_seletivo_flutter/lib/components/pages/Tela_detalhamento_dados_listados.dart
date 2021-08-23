import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:processo_seletivo_flutter/services/Services_detalhamento.dart';
import 'package:http/http.dart' as http;

class TelaDetalhamentoDadosListados extends StatefulWidget {
  final data;

  TelaDetalhamentoDadosListados({this.data});
  @override
  _TelaDetalhamentoDadosListadosState createState() =>
      _TelaDetalhamentoDadosListadosState();
}

class _TelaDetalhamentoDadosListadosState
    extends State<TelaDetalhamentoDadosListados> {
  var dadosObjetoSelecionado;

  var dataParaEnvio;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime data = DateTime.parse(widget.data);
    setState(() {
      dataParaEnvio = DateFormat("yyyy-MM-dd").format(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: obterDetalhamento(http.Client(), dataParaEnvio: dataParaEnvio),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            dadosObjetoSelecionado = snapshot.data[1];

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.purple[900],
                title: Text('Detalhamento'),
              ),
              body: Column(
                children: [],
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('Detalhamento'),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
