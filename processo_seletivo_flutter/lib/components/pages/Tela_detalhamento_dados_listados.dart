import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:processo_seletivo_flutter/components/Componente_cabecalho_tela_detalhamento/Componente_cabecalho_tela_detalhamento.dart';
import 'package:processo_seletivo_flutter/components/lista/Lista_detalhamento.dart';
import 'package:processo_seletivo_flutter/services/Service_nova_media_movel_lista.dart';
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
  List dadosObjetoSelecionado;
  List todasMediasMoveis = [];
  List objetoDaListaSelecionado = [];
  List dadosParaCalcularMedia = [];
  String totalAcumuladoMediaMovel;
  double mediaAcumulada;
  var mediaMovelObjetoSelecionado;
  var mediaMovelDeCasosObjetoSelecionado;
  var totalCasosObjetoSelecionado;
  var totalMortesObjetoSelecionado;
  var acumulado;
  var dataParaEnvio;
  var dataParaCalcularMedia;

  obterDatas() {
    DateTime data = DateTime.parse(widget.data);
    DateTime dataParaCalculo = data.subtract(Duration(days: 15));
    print(dataParaCalculo);
    print(data);
    setState(() {
      dataParaEnvio = DateFormat("yyyy-MM-dd").format(data);
      dataParaCalcularMedia = DateFormat("yyyy-MM-dd").format(dataParaCalculo);
      print(dataParaCalcularMedia);
    });
  }

  obterNovaMedia() {
    obterNovaMediaMovelPelaLista(http.Client(),
            dataParaEnvio: dataParaEnvio,
            dataParaCalculoMedia: dataParaCalcularMedia)
        .then((value) => {
              setState(() {
                mediaMovelObjetoSelecionado = value["mediaMovelMortes"];
                mediaMovelDeCasosObjetoSelecionado =
                    value["mediaMovelConfirmados"];
                totalMortesObjetoSelecionado = value["totalMortes"];
                totalCasosObjetoSelecionado = value["totalNovosCasos"];
                print(value);
              })
            });
  }

  obterDados() {
    var no;
    obterDetalhamento(http.Client(), dataParaEnvio: dataParaEnvio)
        .then((value) => {
              setState(() {
                acumulado = value["acumuladoMediaMovel"].toString();
                todasMediasMoveis.addAll(value["mediaMovelMortes"]);
                dadosObjetoSelecionado = value["dadosObjetoSelecionado"];
                dadosParaCalcularMedia
                    .addAll(value["dadosParaCalcularMedia"][0]);
              })
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.obterDatas();
    this.obterDados();
    this.obterNovaMedia();
  }

  @override
  Widget build(BuildContext context) {
    print(dadosObjetoSelecionado);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Detalhamento'),
      ),
      body: dadosParaCalcularMedia == null ||
              dadosParaCalcularMedia.isEmpty ||
              dadosParaCalcularMedia.length == 0 ||
              todasMediasMoveis == null ||
              todasMediasMoveis.isEmpty ||
              todasMediasMoveis.length == 0 ||
              acumulado == null ||
              acumulado.isEmpty ||
              acumulado.length == 0 ||
              dadosObjetoSelecionado == null ||
              dadosObjetoSelecionado.isEmpty ||
              dadosObjetoSelecionado.length == 0 ||
              mediaMovelObjetoSelecionado == null ||
              mediaMovelObjetoSelecionado.toString().isEmpty ||
              mediaMovelObjetoSelecionado.toString().length == 0
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  ComponenteCabecalhoTelaDetalhamento(
                    dados: dadosObjetoSelecionado,
                    title: widget.data,
                    valorAcumulado: acumulado,
                    mediaMovelObjetoSelecionado: mediaMovelObjetoSelecionado,
                    mediaCasoslObjetoSelecionado:
                        mediaMovelDeCasosObjetoSelecionado,
                    totalCasosObjetoSelecionado: totalCasosObjetoSelecionado,
                    totalMortesObjetoSelecionado: totalMortesObjetoSelecionado,
                  ),
                  Divider(
                    color: Colors.black45,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 13, bottom: 13),
                    child: Text(
                      'Dados utlizados para calcular Média Movel',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  ListaDetalhamento(
                    dados: dadosParaCalcularMedia,
                  )
                ],
              ),
            ),
    );
  }
}
