import 'package:flutter/material.dart';
import 'package:processo_seletivo_flutter/components/pages/Tela_graficos_indices.dart';
import 'package:processo_seletivo_flutter/components/pages/Tela_listagem_dados_covid.dart';

class BottomNavigationRoute extends StatefulWidget {
  const BottomNavigationRoute({Key? key}) : super(key: key);

  @override
  _BottomNavigationRouteState createState() => _BottomNavigationRouteState();
}

class _BottomNavigationRouteState extends State<BottomNavigationRoute> {
  final List<Widget> _telas = [
    TelaGraficosIndices(),
    TelaDeListagemDosDadosCovid(),
  ];
  int paginaAtualIndice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[paginaAtualIndice],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        fixedColor: Colors.purple[900],
        elevation: 50,
        currentIndex: paginaAtualIndice,
        onTap: (indice) {
          setState(() {
            paginaAtualIndice = indice;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.coronavirus),
            label: "Gráficos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Lista",
          ),
        ],
      ),
    );
  }
}
