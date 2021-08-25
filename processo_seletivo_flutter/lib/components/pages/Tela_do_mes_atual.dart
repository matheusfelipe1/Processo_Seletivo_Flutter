import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:processo_seletivo_flutter/components/componente_cabecalho_mes/Componente_cabecalho_mes.dart';
import 'package:processo_seletivo_flutter/components/graficos/componente_diaolog_grafico/Componente_dialogo_grafico_mes.dart';
import 'package:processo_seletivo_flutter/components/lista/Lista_tela_mes.dart';
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
            actions: [
              IconButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Dados deste mês"),
                          content: Container(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ComponenteDialogGraficoMes(
                                  chave: 'Maior Número de Casos:',
                                  valor: maiorNumeroCasos,
                                ),
                                ComponenteDialogGraficoMes(
                                  chave: 'Maior Número de Mortes:',
                                  valor: maiorNumeroMorte,
                                ),
                                ComponenteDialogGraficoMes(
                                  chave: 'Total de Casos:',
                                  valor: totalCasos,
                                ),
                                ComponenteDialogGraficoMes(
                                  chave: 'Total de Mortes:',
                                  valor: totalMortes,
                                ),
                                ComponenteDialogGraficoMes(
                                  chave: 'Número de Casos Hoje:',
                                  valor: casosAtualizacao,
                                ),
                                ComponenteDialogGraficoMes(
                                  chave: 'Número de Mortes Hoje:',
                                  valor: morteAtualizacao,
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                  icon: Icon(Icons.info, color: Colors.white))
            ],
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
                child: Column(
                  children: [
                    ComponenteCabecalhoMes(
                      maiorNumeroCasos: maiorNumeroCasos,
                      maiorNumeroMorte: maiorNumeroMorte,
                      totalCasos: totalCasos,
                      totalMortes: totalMortes,
                      casosAtualizacao: casosAtualizacao,
                      morteAtualizacao: morteAtualizacao,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Divider(color: Colors.black38),
                    ),
                    ListaTelaMes(
                      lista: dadosDoMes,
                    )
                  ],
                ),
              ));
  }
}
