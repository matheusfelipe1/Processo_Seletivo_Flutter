import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ComponenteCabecalhoTelaDetalhamento extends StatefulWidget {
  final List dados;
  final List dadosParaCalcularMedia;
  final String title;
  final valorAcumulado;
  final mediaMovelObjetoSelecioado;
  ComponenteCabecalhoTelaDetalhamento(
      {this.dados,
      this.title,
      this.dadosParaCalcularMedia,
      this.valorAcumulado,
      this.mediaMovelObjetoSelecioado});
  @override
  _ComponenteCabecalhoTelaDetalhamentoState createState() =>
      _ComponenteCabecalhoTelaDetalhamentoState();
}

class _ComponenteCabecalhoTelaDetalhamentoState
    extends State<ComponenteCabecalhoTelaDetalhamento> {
  @override
  void initState() {
    super.initState();
  }

  Widget renderizaDados(String parametro, var dado) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Wrap(
        children: [
          Text("$parametro: "),
          Text(dado, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget renderizaTela(List lista) {
    var title = widget.title.replaceAll('z', 's');
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lista
            .map((e) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e["Country"].split("z").join("s"),
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        renderizaDados('Data', title),
                        renderizaDados('Mortos', e["Deaths"].toString()),
                        renderizaDados(
                            'Confirmados', e['Confirmed'].toString()),
                        renderizaDados(
                            'Recuperados', e['Recovered'].toString()),
                        renderizaDados('Média Movel de Mortes',
                            "${widget.mediaMovelObjetoSelecioado}"),
                        renderizaDados('Total das Médias de Mortes Solicitadas',
                            "${widget.valorAcumulado}")
                      ],
                    ),
                  ),
                ))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        renderizaTela(widget.dados),
        Divider(
          color: Colors.black,
        ),
        Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            child: Text('Dados o para calculo da Média Movel',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
        Column(
          children: widget.dadosParaCalcularMedia.map((e) {
            DateTime data = DateTime.parse(e['Date'].toString().split("T")[0]);
            return new Column(
              children: [
                Container(
                    child: Card(
                        child: ListTile(
                  title: Text(e["Country"].toString().replaceAll("z", "s")),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Novas Mortes: ${e["newDeaths"].toString()}"),
                        Text(
                            "Total de Mortes neste dia: ${e["Deaths"].toString()}"),
                        Text("Novas Casos: ${e["newCases"].toString()}"),
                        Text(
                            "Total de Casos neste dia: ${e["Confirmed"].toString()}"),
                      ]),
                  trailing: Text(DateFormat("dd-MM-yyyy").format(data)),
                )))
              ],
            );
          }).toList(),
        )
      ],
    );
  }
}
