import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:la_quiniela/src/model/bet.dart';
import 'package:la_quiniela/src/services/match_services.dart';
import 'package:la_quiniela/src/model/match.dart';
import 'package:intl/intl.dart';

import '../login_page.dart';

class ApuestasPage extends StatefulWidget {
  ApuestasPage({Key key}) : super(key: key);

  @override
  _ApuestasPageState createState() => _ApuestasPageState();
}

class _ApuestasPageState extends State<ApuestasPage> {
  final MatchService _matchService = MatchService();

  List<Bet> bets = List<Bet>();

  @override
  Widget build(BuildContext context) {
    //_matchService.getTeams();
    //_matchService.addMatch();
    _matchService.getMatchsByWeek();
    return Scaffold(
      appBar: AppBar(
        title: Text('Apuestas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Salir',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          )
        ],
      ),
      body: _buildCards(),
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
          ),
        ],
      ),
    );
  }

  List<Widget> _createCardsApuesta({String local, String visitante, Bet bet}) {
    //;
    return [
      _createCardAwayTeam(visitante, bet),
      Text(' vs '),
      _createCardHostTeam(local, bet),
    ];
  }

  Widget _createCardHostTeam(String team, Bet bet) {
    bool typeIcon = bet.isHostWin ?? false;
    return InkWell(
      onTap: () {
        setState(() {
          bet.isHostWin = true;
        });
      },
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
              color: typeIcon ? Colors.green : Colors.red)
        ],
      ),
    );
  }

  Widget _createCardAwayTeam(String team, Bet bet) {
    bool typeIcon = bet.isAwayWin ?? false;
    return InkWell(
      onTap: () {
        setState(() {
          bet.isHostWin = true;
        });
      },
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
              color: typeIcon ? Colors.green : Colors.red)
        ],
      ),
    );
  }

  Widget _crearApuestaButton() {
    return RaisedButton(
        child: Text('Confirmar Apuesta'),
        textColor: Theme.of(context).primaryColor,
        shape: StadiumBorder(),
        onPressed: () async {
          // //validaciones
          // if (1 != 1) {
          //   return;
          // }
          // await _auth.registration(email, password).then((value) {
          //   mostrarAlert(
          //     context: context,
          //     title: 'Exito !!!',
          //     text: 'Usuario registrado correctamente',
          //     onPressedOk: () {
          //       Navigator.of(context).pop();
          //     },
          //   );
          // }).catchError((e) {
          //   String errorMsg = e.message;
          //   mostrarAlert(
          //     context: context,
          //     title: 'Error !!!',
          //     text: '$errorMsg',
          //     onPressedOk: () {
          //       Navigator.of(context).pop();
          //     },
          //   );
          // });
        });
  }

  FutureBuilder<QuerySnapshot> _buildCards() {
    return FutureBuilder<QuerySnapshot>(
      future: _matchService.getMatchsByWeek(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error al recuperar info');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          //Map<String, dynamic> data = snapshot;
          List<Widget> result = List<Widget>();

          var separator = SizedBox(height: 10.0);

          result.add(Divider());
          result.add(_buildCurrenWeek());
          result.add(Divider());

          snapshot.data.docs.forEach((element) {
            Match m = Match.fromJson(element.data());
            Bet b = Bet(match: m);
            bets.add(b);
            result.add(_cardTypeDouble(m, b));
            result.add(separator);
          });
          result.add(_crearApuestaButton());
          return ListView(
            padding: EdgeInsets.all(10.0),
            children: result,
          );
        }

        return Text('Recuperando Informacion');
      },
    );
  }

  FutureBuilder<QuerySnapshot> _buildCurrenWeek() {
    return FutureBuilder<QuerySnapshot>(
      future: _matchService.getCurrentWeek(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error al recuperar info');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              snapshot.data.docs.first.data()['description'].toString(),
              style: TextStyle(fontSize: 18.0),
            ),
          );
        }

        return Text('Recuperando Informacion');
      },
    );
  }
}
