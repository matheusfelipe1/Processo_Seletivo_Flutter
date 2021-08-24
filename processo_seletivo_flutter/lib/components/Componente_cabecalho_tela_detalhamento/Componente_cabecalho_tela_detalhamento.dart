import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ComponenteCabecalhoTelaDetalhamento extends StatefulWidget {
  final List dados;
  final String title;
  final valorAcumulado;
  final mediaMovelObjetoSelecioado;
  ComponenteCabecalhoTelaDetalhamento(
      {this.dados,
      this.title,
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
    print(widget.dados);
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
      ],
    );
  }
}
