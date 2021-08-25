import 'package:flutter/material.dart';

class ComponenteDialogGraficoMes extends StatelessWidget {
  final String chave;
  final valor;
  ComponenteDialogGraficoMes({this.chave, this.valor});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: Wrap(
          children: [
            Text(chave),
            Text("$valor", style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ));
  }
}
