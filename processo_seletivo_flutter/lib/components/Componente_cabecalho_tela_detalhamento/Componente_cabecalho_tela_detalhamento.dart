import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:processo_seletivo_flutter/components/pages/Tela_graficos_detalhamento.dart';

class ComponenteCabecalhoTelaDetalhamento extends StatefulWidget {
  final List dados;
  final String title;
  final valorAcumulado;
  var mediaMovelObjetoSelecionado;
  var mediaCasoslObjetoSelecionado;
  var totalMortesObjetoSelecionado;
  var totalCasosObjetoSelecionado;
  ComponenteCabecalhoTelaDetalhamento(
      {this.dados,
      this.title,
      this.valorAcumulado,
      this.mediaMovelObjetoSelecionado,
      this.mediaCasoslObjetoSelecionado,
      this.totalMortesObjetoSelecionado,
      this.totalCasosObjetoSelecionado});
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e["Country"].split("z").join("s"),
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                return Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return TelaGraficosDetalhamento(
                                    mediaMovelCasosObjetoSelecionado:
                                        widget.mediaCasoslObjetoSelecionado,
                                    mediaMovelObjetoSelecionado:
                                        widget.mediaMovelObjetoSelecionado,
                                    totalCasosObjetoSelecionado:
                                        widget.totalCasosObjetoSelecionado,
                                    totalMortesObjetoSelecionado:
                                        widget.totalMortesObjetoSelecionado,
                                  );
                                }));
                              },
                              backgroundColor: Colors.blue[900],
                              child: Icon(Icons.graphic_eq_outlined),
                            ),
                          ],
                        ),
                        renderizaDados('Data', title),
                        renderizaDados('Mortos', e["Deaths"].toString()),
                        renderizaDados(
                            'Confirmados', e['Confirmed'].toString()),
                        renderizaDados(
                            'Recuperados', e['Recovered'].toString()),
                        renderizaDados('Média Movel de Mortes',
                            "${NumberFormat("00.00").format(widget.mediaMovelObjetoSelecionado)}"),
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
