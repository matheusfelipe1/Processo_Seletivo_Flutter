import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:processo_seletivo_flutter/components/Componente_cabecalho_tela_detalhamento/Componente_cabecalho_tela_detalhamento.dart';
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
  double mediaMovelObjetoSelecioado;
  var dataParaEnvio;
  var dataParaCalcularMedia;

  obterDatas() {
    DateTime data = DateTime.parse(widget.data);
    DateTime dataParaCalculo = data.subtract(Duration(days: 15));
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
                mediaMovelObjetoSelecioado =
                    value["mediaMovelMortes"].toDouble();
                print(mediaMovelObjetoSelecioado);
              })
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.obterDatas();
    this.obterNovaMedia();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: obterDetalhamento(http.Client(), dataParaEnvio: dataParaEnvio),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            dadosObjetoSelecionado = json.decode(snapshot.data.toString());
            todasMediasMoveis.addAll(dadosObjetoSelecionado[0]);
            objetoDaListaSelecionado.addAll(dadosObjetoSelecionado[1]);
            dadosParaCalcularMedia.addAll(dadosObjetoSelecionado[2]);
            mediaAcumulada = dadosObjetoSelecionado[3].toDouble();
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.purple[900],
                title: Text('Detalhamento'),
              ),
              body: ListView(
                children: [
                  ComponenteCabecalhoTelaDetalhamento(
                    dados: objetoDaListaSelecionado,
                    data: widget.data,
                    valorAcumulado: mediaAcumulada,
                    mediaMovelObjetoSelecioado: mediaMovelObjetoSelecioado,
                  )
                ],
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.purple[900],
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
