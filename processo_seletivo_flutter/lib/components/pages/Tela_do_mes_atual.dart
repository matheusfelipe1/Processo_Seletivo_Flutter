import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:processo_seletivo_flutter/components/componente_cabecalho_mes/Componente_cabecalho_mes.dart';
import 'package:processo_seletivo_flutter/services/Service_tela_inicio.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TelaInicio extends StatefulWidget {
  @override
  _TelaInicioState createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> {
  String latitude;
  String longitude;
  var maiorNumeroMorte;
  var maiorNumeroCasos;
  var totalCasos;
  var totalMortes;
  var morteAtualizacao;
  var casosAtualizacao;
  List dadosDoMes = [];

  requisicao() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
    });

    await obterTelaInicio(http.Client(),
            latitude: latitude, longitude: longitude)
        .then((value) => setState(() {
              maiorNumeroCasos = value["maiorNumeroCasos"];
              maiorNumeroMorte = value["maiorNumeroMortes"];
              totalCasos = value["totalCasos"];
              totalMortes = value["totalMortes"];
              morteAtualizacao = value["mortesDaUltimaAtualizacao"];
              casosAtualizacao = value["casosDaUltimaAtualizacao"];
              dadosDoMes.addAll(value["results"]);
            }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.requisicao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Icon(Icons.coronavirus),
            title: Text("Processo Seletivo Mobilus"),
            backgroundColor: Colors.blue[900]),
        body: dadosDoMes == null ||
                dadosDoMes.length == 0 ||
                totalMortes.toString().isEmpty ||
                totalMortes.toString() == null ||
                totalMortes.toString().length == 0 ||
                totalCasos.toString().isEmpty ||
                totalCasos.toString() == null ||
                totalCasos.toString().length == 0 ||
                maiorNumeroCasos.toString().isEmpty ||
                maiorNumeroCasos.toString() == null ||
                maiorNumeroCasos.toString().length == 0 ||
                maiorNumeroMorte.toString().isEmpty ||
                maiorNumeroMorte.toString() == null ||
                maiorNumeroMorte.toString().length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: ComponenteCabecalhoMes(
                  maiorNumeroCasos: maiorNumeroCasos,
                  maiorNumeroMorte: maiorNumeroMorte,
                  totalCasos: totalCasos,
                  totalMortes: totalMortes,
                  casosAtualizacao: casosAtualizacao,
                  morteAtualizacao: morteAtualizacao,
                ),
              ));
  }
}
