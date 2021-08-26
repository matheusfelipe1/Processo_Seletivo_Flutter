import 'package:flutter/material.dart';
import 'package:processo_seletivo_flutter/components/graficos/componente_grafico_detalhamento/Componente_grafico_detalhamento.dart';
import 'package:intl/intl.dart';

class TelaGraficosDetalhamento extends StatefulWidget {
  final mediaMovelObjetoSelecionado;
  final mediaMovelCasosObjetoSelecionado;
  final totalCasosObjetoSelecionado;
  final totalMortesObjetoSelecionado;
  TelaGraficosDetalhamento(
      {this.mediaMovelObjetoSelecionado,
      this.mediaMovelCasosObjetoSelecionado,
      this.totalCasosObjetoSelecionado,
      this.totalMortesObjetoSelecionado});
  @override
  _TelaGraficosDetalhamentoState createState() =>
      _TelaGraficosDetalhamentoState();
}

class _TelaGraficosDetalhamentoState extends State<TelaGraficosDetalhamento> {
  Widget conteudoAlerta(String dados, var valor) {
    return Wrap(
      children: [
        Text("$dados: "),
        Text("$valor", style: TextStyle(fontWeight: FontWeight.bold))
      ],
    );
  }

  Widget actionsAlerta(Color color, String dados) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Wrap(children: [
        SizedBox(
            height: 20,
            width: 20,
            child: Container(
              margin: EdgeInsets.only(right: 6),
              color: color,
            )),
        Text(dados)
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Grafico do Detalhamento'),
        actions: [
          IconButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: AlertDialog(
                          title: Text("Dados respectivos a data selecionada."),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              conteudoAlerta(
                                  'Média Movel de Mortes',
                                  NumberFormat("00.00").format(
                                      widget.mediaMovelObjetoSelecionado)),
                              conteudoAlerta('Total de Mortes',
                                  widget.totalMortesObjetoSelecionado),
                              conteudoAlerta(
                                  'Média Movel de Novos Casos',
                                  NumberFormat("00.00").format(
                                      widget.mediaMovelCasosObjetoSelecionado)),
                              conteudoAlerta('Total de Novos Casos',
                                  widget.totalCasosObjetoSelecionado),
                            ],
                          ),
                          actions: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  actionsAlerta(
                                      Colors.black, 'Média Movel de Mortes'),
                                  actionsAlerta(Colors.yellow,
                                      'Média Movel de Novos Casos'),
                                  actionsAlerta(
                                      Colors.blue, 'Total de Novos Casos'),
                                  actionsAlerta(Colors.red, 'Total de Mortes'),
                                ],
                              ),
                            )
                          ]),
                    );
                  }),
              icon: Icon(Icons.info, color: Colors.white))
        ],
      ),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ComponenteGraficoDetalhamento(
            mediaMovelCasosObjetoSelecionado:
                widget.mediaMovelCasosObjetoSelecionado,
            mediaMovelObjetoSelecionado: widget.mediaMovelObjetoSelecionado,
            totalCasosObjetoSelecionado: widget.totalCasosObjetoSelecionado,
            totalMortesObjetoSelecionado: widget.totalMortesObjetoSelecionado,
          )),
    );
  }
}
