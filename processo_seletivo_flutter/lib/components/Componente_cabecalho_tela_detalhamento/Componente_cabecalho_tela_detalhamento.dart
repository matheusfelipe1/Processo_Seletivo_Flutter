import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ComponenteCabecalhoTelaDetalhamento extends StatefulWidget {
  final List dados;
  final String data;
  ComponenteCabecalhoTelaDetalhamento({this.dados, this.data});
  @override
  _ComponenteCabecalhoTelaDetalhamentoState createState() =>
      _ComponenteCabecalhoTelaDetalhamentoState();
}

class _ComponenteCabecalhoTelaDetalhamentoState
    extends State<ComponenteCabecalhoTelaDetalhamento> {
  Widget renderizaDados(String parametro, var dado) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          Text("$parametro: "),
          Text(dado, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget renderizaTela(List lista) {
    var data = widget.data
        .split(
          "T",
        )[0]
        .split("-")
        .reversed
        .join('/');
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
                        renderizaDados('Data', data),
                        renderizaDados('Mortos', e["Deaths"].toString()),
                        renderizaDados(
                            'Confirmados', e['Confirmed'].toString()),
                        renderizaDados(
                            'Recuperados', e['Recovered'].toString()),
                        CircularPercentIndicator(
                          animation: true,
                          animationDuration: 3000,
                          percent: 1.0,
                          radius: 60.0,
                          progressColor: Colors.blue,
                          center: Text('Dados'),
                        ),
                      ],
                    ),
                  ),
                ))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return renderizaTela(widget.dados);
  }
}
