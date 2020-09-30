import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:la_quiniela/src/model/bet.dart';
import 'package:la_quiniela/src/services/match_services.dart';
import 'package:la_quiniela/src/model/match.dart';

import 'package:intl/intl.dart';

class MisApuestasPage extends StatefulWidget {
  @override
  _MisApuestasPageState createState() => _MisApuestasPageState();
}

class _MisApuestasPageState extends State<MisApuestasPage> {
  final MatchService _matchService = MatchService();

  String _selectedWeek; //= Week('Seleccione ....');

  @override
  Widget build(BuildContext context) {
    //matchsByWeeks = _matchService.getMatchsByWeek();
    return _buildCards();
  }

  List<Widget> _createCardsApuesta({String local, String visitante, Bet bet}) {
    return [
      _createCardAwayTeam(visitante, bet),
      Text(' vs '),
      _createCardHostTeam(local, bet),
    ];
  }

  Widget _createCardHostTeam(String team, Bet bet) {
    bool typeIcon = bet.isHostWin ?? false;
    return InkWell(
      child: Column(
        children: [
          Image(
            image: AssetImage('assets/nfl/${team.toLowerCase()}.png'),
            height: 50,
            fit: BoxFit.fitWidth,
          ),
          Text(
            '$team',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 10.0),
          Icon(typeIcon ? Icons.done_outline : Icons.clear_outlined,
              color: typeIcon ? Colors.green : Colors.red),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Widget _createCardAwayTeam(String team, Bet bet) {
    bool typeIcon = bet.isAwayWin ?? false;

    return InkWell(
      child: Column(
        children: [
          Image(
            image: AssetImage('assets/nfl/${team.toLowerCase()}.png'),
            height: 50,
            fit: BoxFit.fitWidth,
          ),
          Text(
            '$team',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 10.0),
          Icon(typeIcon ? Icons.done_outline : Icons.clear_outlined,
              color: typeIcon ? Colors.green : Colors.red),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Widget _cardTypeDouble(Match match, Bet bet) {
    String formatDate(DateTime date) =>
        new DateFormat("EEEE, d MMMM HH:mm").format(date);
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('${formatDate(match.gameDate.toDate())}'),
                Text(' / '),
                Text(match.placeGameName)
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _createCardsApuesta(
                local: match.hostTeam, visitante: match.awayTeam, bet: bet),
          )
        ],
      ),
    );
  }

  FutureBuilder<QuerySnapshot> _buildCards() {
    return FutureBuilder<QuerySnapshot>(
      future: _matchService.getBetsByUserByWeek('NFL', _selectedWeek),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          snapshot.error.toString();
          return Center(
              child:
                  Text('Error al recuperar informacion: \n ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          //Map<String, dynamic> data = snapshot;
          List<Widget> result = List<Widget>();

          var separator = SizedBox(height: 10.0);

          result.add(Divider());
          result.add(_crearDropdownWeek());
          result.add(Divider());

          if (snapshot.data == null || snapshot.data.docs.isEmpty) {
            result.add(Text('No hay informacion'));
          } else {
            snapshot.data.docs.forEach((element) async {
              Bet b = Bet.fromJson(element.data());
              DocumentSnapshot d = await element.data()['match'].get();
              b.match = Match.fromJson(d.data());

              result.add(_cardTypeDouble(b.match, b));
              result.add(separator);
            });
          }

          return ListView(
            padding: EdgeInsets.all(10.0),
            children: result,
          );
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
    }
    return res;
  }
}
