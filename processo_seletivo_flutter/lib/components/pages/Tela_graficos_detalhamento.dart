import 'package:flutter/material.dart';
import 'package:processo_seletivo_flutter/components/graficos/componente_grafico_detalhamento/Componente_grafico_detalhamento.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text('Grafico do Detalhamento'),
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
