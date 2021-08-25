import 'package:flutter/material.dart';
import 'package:processo_seletivo_flutter/components/pages/Tela_graficos_indices.dart';
import 'package:processo_seletivo_flutter/components/pages/Tela_do_mes_atual.dart';
import 'package:processo_seletivo_flutter/components/pages/Tela_listagem_dados_covid.dart';

class BottomNavigationRoute extends StatefulWidget {
  @override
  _BottomNavigationRouteState createState() => _BottomNavigationRouteState();
}

class _BottomNavigationRouteState extends State<BottomNavigationRoute> {
  final List<Widget> _telas = [
    TelaDeListagemDosDadosCovid(),
    TelaInicio(),
    TelaGraficosIndices(),
  ];
  int paginaAtualIndice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _telas[paginaAtualIndice],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtualIndice,
        backgroundColor: Colors.white,
        onTap: (indice) {
          setState(() {
            paginaAtualIndice = indice;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Lista",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: "Hoje",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq),
            label: "Gráficos",
          ),
        ],
      ),
    );
  }
}
