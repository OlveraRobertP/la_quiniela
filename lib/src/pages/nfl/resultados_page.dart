import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:la_quiniela/src/model/resultados.dart';
import 'package:la_quiniela/src/services/match_services.dart';

class ResultadosPage extends StatefulWidget {
  @override
  _ResultadosPageState createState() => _ResultadosPageState();
}

class _ResultadosPageState extends State<ResultadosPage> {
  final MatchService _matchService = MatchService();

  List<DataColumn> tableColumns = [
    DataColumn(label: Text('Jugador')),
    DataColumn(
      label: Center(child: Text('Total')),
    ),
  ];

  String _selectedWeek;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: createPage(),
      ),
    );
  }

  List<Widget> createPage() {
    List<Widget> result = List<Widget>();

    result.add(Divider());
    result.add(_crearDropdownWeek());
    result.add(Divider());
    if (this._selectedWeek != null) result.add(_createTableResults());
    return result;
  }

  Widget _createTableResults() {
    double maxWidth = MediaQuery.of(context).size.width * 0.7;

    return FutureBuilder(
      future:
          _matchService.getResultsTickeBetsByWeek('NFL', this._selectedWeek),
      builder:
          (BuildContext context, AsyncSnapshot<List<Resultados>> snapshot) {
        List<Resultados> resultados = snapshot.data;
        if (snapshot.connectionState == ConnectionState.done) {
          return ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: SingleChildScrollView(
                  child: DataTable(
                columns: tableColumns,
                rows: _generateRows(resultados),
              )));
        }
        return new CircularProgressIndicator(
          backgroundColor: Color(0xFF862633),
        );
      },
    );
  }

  Widget _crearDropdownWeek() {
    return FutureBuilder(
        future: _matchService.getWeeksByTournament('NFL'),
        builder: (context, snapshot) {
          return DropdownButton(
            autofocus: true,
            elevation: 20,
            hint: Text(
              'Selecione... ',
              style: TextStyle(fontSize: 18.0),
            ),
            value: _selectedWeek,
            icon: Icon(Icons.arrow_drop_down_outlined),
            items: _getItemsDropDown(snapshot),
            onChanged: (opt) {
              setState(() {
                _selectedWeek = opt;
              });
            },
          );
        });
  }

  List<DropdownMenuItem<String>> _getItemsDropDown(
      AsyncSnapshot<QuerySnapshot> snapshot) {
    List<DropdownMenuItem<String>> res = new List<DropdownMenuItem<String>>();
    if (snapshot.connectionState == ConnectionState.done) {
      snapshot.data.docs.forEach((element) {
        res.add(DropdownMenuItem<String>(
          child: Text(element.data()['description']),
          value: element.data()['description'],
        ));
      });
      return res;
    }
  }

  _generateRows(List<Resultados> resultados) {
    List<DataRow> result = List<DataRow>();

    if (resultados != null && resultados.isNotEmpty) {
      resultados.forEach((res) {
        result.add(DataRow(cells: <DataCell>[
          DataCell(Text('${res.user}')),
          DataCell(Center(
            child: Text(
              '${res.totalAciertos}',
            ),
          )),
        ]));
      });
    }
    return result;
  }
}
