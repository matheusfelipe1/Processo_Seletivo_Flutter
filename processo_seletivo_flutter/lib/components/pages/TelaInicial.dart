import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:processo_seletivo_flutter/services/Services_lista_dados.dart';
import 'dart:io';
import 'package:intl/intl.dart';
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
  final TextEditingController _pesquisa = new TextEditingController();
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

  Widget filtrando() {
    return Container(
      height: 35.0,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Center(
        child: TextField(
            controller: _pesquisa,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: "Buscar",
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
            ),
            style: const TextStyle(color: Colors.black, fontSize: 16.0),
            onChanged: (e) => iniciandoPesquisa(e)),
      ),
    );
  }

  void iniciarPesquisa() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: pararPesquisa));
    setState(() {
      pesquisando = true;
    });
  }

  void pararPesquisa() {
    if (_pesquisa.toString().isNotEmpty ||
        _pesquisa.toString().length > 0 ||
        _pesquisa.toString() != null) {
      setState(() {
        _pesquisa.clear();
        pesquisando = false;
        dadosListaApi.clear();
        dadosListaApi.addAll(lista);
      });
    }
  }

  void iniciandoPesquisa(String query) {
    dadosListaApi.clear();

    if (query.length > 0) {
      Set.from(lista).forEach((element) {
        setState(() {
          if (element.toString().contains(query)) {
            dadosListaApi.add(element);
          }
        });
      });
    }
    if (query.isEmpty || query.length == 0 || query == null) {
      dadosListaApi.addAll(lista);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.purple[900],
          title: pesquisando ? filtrando() : Text('Covid-19 no Brasil'),
          leading: pesquisando ? null : Icon(Icons.coronavirus),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                  child: pesquisando ? Icon(Icons.cancel) : Icon(Icons.search),
                  onTap: () => {
                        setState(() {
                          pesquisando = !pesquisando;
                          pesquisando
                              ? iniciarPesquisa()
                              : {pararPesquisa(), Navigator.of(context).pop()};
                        }),
                      }),
            )
          ],
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
          DateTime data =
              DateTime.parse(widget.renderizaDados[indice]['Date'].toString());
          return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: ListTile(
                    title: Text(
                        widget.renderizaDados[indice]['Country'].toString()),
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
                    trailing: Text(DateFormat("dd/MM/yyyy").format(data))),
              ));
        });
  }
}
