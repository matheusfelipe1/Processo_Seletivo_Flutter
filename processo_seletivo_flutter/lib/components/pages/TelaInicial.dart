import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:processo_seletivo_flutter/services/Services_lista_dados.dart';
import 'dart:io';

import 'package:http/http.dart' as http;

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  List lista = [];
  List dadosListaApi = [];
  bool pesquisando = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obterlista(http.Client()).then((value) => parseDados(value));
  }

  void parseDados(List novalista) {
    novalista.forEach((element) {
      setState(() {
        dadosListaApi.add(element);
      });
    });
    lista.addAll(dadosListaApi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          title: Text('Covid-19 no Brasil'),
          leading: Icon(Icons.coronavirus),
          actions: [pesquisando ? Icon(Icons.cancel) : Icon(Icons.search)],
        ),
        body: dadosListaApi == null || dadosListaApi.length == 0
            ? Center(child: CircularProgressIndicator())
            : Lista(
                renderizaDados: dadosListaApi,
              ));
  }
}

class Lista extends StatefulWidget {
  final List renderizaDados;
  Lista({required this.renderizaDados});
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.renderizaDados.length == null
            ? 0
            : widget.renderizaDados.length,
        itemBuilder: (BuildContext context, int indice) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
                child: ListTile(
              title: Text(widget.renderizaDados[indice]['Country'].toString()),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Mortes: ${widget.renderizaDados[indice]['Deaths'].toString()}"),
                  Text(
                      "Confirmados: ${widget.renderizaDados[indice]['Confirmed'].toString()}"),
                  Text(
                      "Recuperados: ${widget.renderizaDados[indice]['Recovered'].toString()}"),
                ],
              ),
              trailing: Text(widget.renderizaDados[indice]['Date'].toString()),
            )),
          );
        });
  }
}
