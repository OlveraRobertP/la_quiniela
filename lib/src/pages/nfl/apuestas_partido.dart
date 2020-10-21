import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:la_quiniela/src/model/resultados.dart';
import 'package:la_quiniela/src/services/match_services.dart';

class ApuestasPorPartidoPage extends StatefulWidget {
  ApuestasPorPartidoPage({Key key}) : super(key: key);

  @override
  _ApuestasPorPartidoPageState createState() => _ApuestasPorPartidoPageState();
}

class _ApuestasPorPartidoPageState extends State<ApuestasPorPartidoPage> {
  final MatchService _matchService = MatchService();
  String _selectedWeek;
  String _selectedMacth;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: createPage(),
          ),
        )
      ],
    );
  }

  List<Widget> createPage() {
    List<Widget> result = List<Widget>();

    // /result.add(Divider());
    result.add(_crearDropdownWeek());
    result.add(Divider());
    result.add(_crearDropdownPartidos());
    result.add(Divider());
    if (this._selectedMacth != null) result.add(_createTableResults());
    return result;
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
                _selectedMacth = null;
              });
            },
          );
        });
  }

  Widget _crearDropdownPartidos() {
    if (this._selectedWeek != null) {
      return FutureBuilder(
          future: _matchService.getMatchByWeek(this._selectedWeek),
          builder: (context, snapshot) {
            return DropdownButton(
              autofocus: true,
              elevation: 20,
              hint: Text(
                'Selecione... ',
                style: TextStyle(fontSize: 18.0),
              ),
              value: _selectedMacth,
              icon: Icon(Icons.arrow_drop_down_outlined),
              items: _getItemsDropDownPartidos(snapshot),
              onChanged: (opt) {
                setState(() {
                  _selectedMacth = opt;
                });
              },
            );
          });
    } else {
      return Text('');
    }
  }

  List<DropdownMenuItem<String>> _getItemsDropDown(
      AsyncSnapshot<QuerySnapshot> snapshot) {
    List<DropdownMenuItem<String>> res = new List<DropdownMenuItem<String>>();
    if (snapshot.connectionState == ConnectionState.done) {
      snapshot.data.docs.forEach((element) {
        res.add(DropdownMenuItem<String>(
          child: Text(element.data()['description']),
          value: element.id,
        ));
      });
      return res;
    }
  }

  List<DropdownMenuItem<String>> _getItemsDropDownPartidos(
      AsyncSnapshot<QuerySnapshot> snapshot) {
    List<DropdownMenuItem<String>> res = new List<DropdownMenuItem<String>>();
    if (snapshot.connectionState == ConnectionState.done) {
      snapshot.data.docs.forEach((element) {
        res.add(DropdownMenuItem<String>(
          child: Text(
              "${element.data()['awayTeam']} vs ${element.data()['hostTeam']}"),
          value: element.id,
        ));
      });
      return res;
    }
  }

  Widget _createTableResults() {
    // double maxWidth = MediaQuery.of(context).size.width * 0.7;

    return FutureBuilder(
      future: _matchService.getApuestasByMatch(this._selectedMacth),
      builder: (BuildContext context,
          AsyncSnapshot<List<ApuestasPorPartido>> snapshot) {
        List<ApuestasPorPartido> resultados = snapshot.data;
        if (snapshot.connectionState == ConnectionState.done) {
          return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: tableColumns,
                rows: _generateRows(resultados),
              ));
        }
        return new CircularProgressIndicator(
          backgroundColor: Color(0xFF862633),
        );
      },
    );
  }

  List<DataColumn> tableColumns = [
    DataColumn(label: Text('Jugador')),
    DataColumn(
      label: Center(child: Text('Apuesta')),
    ),
  ];

  _generateRows(List<ApuestasPorPartido> resultados) {
    List<DataRow> result = List<DataRow>();

    if (resultados != null && resultados.isNotEmpty) {
      resultados.forEach((res) {
        result.add(DataRow(cells: <DataCell>[
          DataCell(Text('${res.user}')),
          DataCell(Center(
            child: Text(
              '${res.ganador}',
            ),
          )),
        ]));
      });
    }
    return result;
  }
}
