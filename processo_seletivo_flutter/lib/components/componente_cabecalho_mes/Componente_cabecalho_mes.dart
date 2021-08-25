import 'package:flutter/material.dart';
import 'package:processo_seletivo_flutter/components/graficos/Componente_grafico_mes/Componente_grafico_mes.dart';

class ComponenteCabecalhoMes extends StatefulWidget {
  final maiorNumeroMorte;
  final maiorNumeroCasos;
  final totalCasos;
  final totalMortes;
  final morteAtualizacao;
  final casosAtualizacao;
  ComponenteCabecalhoMes(
      {this.maiorNumeroCasos,
      this.maiorNumeroMorte,
      this.totalCasos,
      this.totalMortes,
      this.casosAtualizacao,
      this.morteAtualizacao});
  @override
  _ComponenteCabecalhoMesState createState() => _ComponenteCabecalhoMesState();
}

class _ComponenteCabecalhoMesState extends State<ComponenteCabecalhoMes> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 20, bottom: 7),
                child: Center(
                    child: Text(
                  "Dados do mês",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))),
            Container(
              child: Divider(
                color: Colors.black26,
              ),
            ),
            Text("Relação Maior Número de Casos e Mortes",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
                child: ComponenteGraficoMes(
              variavelA: widget.maiorNumeroMorte,
              variavelB: widget.maiorNumeroCasos,
              textA: 'Morte',
              textB: 'Caso',
            )),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Divider(
                color: Colors.black26,
              ),
            ),
            Text("Relação Total Número de Casos e Mortes",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
                child: ComponenteGraficoMes(
              variavelB: widget.totalCasos,
              variavelA: widget.totalMortes,
              textA: 'Morte',
              textB: 'Caso',
            )),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Divider(
                color: Colors.black26,
              ),
            ),
            Text("Relação Hoje Número de Casos e Mortes",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
                child: ComponenteGraficoMes(
              variavelB: widget.casosAtualizacao,
              variavelA: widget.morteAtualizacao,
              textA: 'Morte',
              textB: 'Caso',
            )),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Divider(
                color: Colors.black26,
              ),
            ),
            Text("Relação Maior Número de Mortes e Mortes Hoje",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
                child: ComponenteGraficoMes(
              variavelB: widget.maiorNumeroMorte,
              variavelA: widget.morteAtualizacao,
              textA: 'Mortes Hoje',
              textB: 'Maiores Mortes',
            )),
          ],
        ),
      ),
    );
  }
}
