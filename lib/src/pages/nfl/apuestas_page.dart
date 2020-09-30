import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:la_quiniela/src/model/bet.dart';
import 'package:la_quiniela/src/services/match_services.dart';
import 'package:la_quiniela/src/model/match.dart';
import 'package:intl/intl.dart';
import 'package:la_quiniela/src/utils/ui_utils.dart';
import 'package:ntp/ntp.dart';

class TeamCardWidget extends StatefulWidget {
  //String matchId;
  Match match;
  Bet bet;
  TeamCardWidget(this.match, this.bet);

  @override
  _TeamCardWidgetState createState() =>
      _TeamCardWidgetState(this.match, this.bet);
}

class _TeamCardWidgetState extends State<TeamCardWidget> {
  //String matchId;
  Match match;
  Bet bet;
  _TeamCardWidgetState(this.match, this.bet);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _createCardsApuesta(
          local: match.hostTeam, visitante: match.awayTeam, bet: bet),
    );
  }

  List<Widget> _createCardsApuesta({String local, String visitante, Bet bet}) {
    return [
      _createCardAwayTeam(visitante, bet),
      Text(' vs '),
      _createCardHostTeam(local, bet),
    ];
  }

  Widget _crearInput(Bet bet, String type) {
    return Container(
      width: 70,
      child: TextField(
        // autofocus: true,
        //textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.number,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: '0',
          //helperText: 'Sólo es el nombre',
          //suffixIcon: Icon(Icons.accessibility),
          //icon: Icon(Icons.account_circle)
        ),
        onChanged: (valor) {
          setState(() {
            if (type == 'host') {
              bet.localResult = double.parse(valor);
            } else if (type == 'away') {
              bet.awayResult = double.parse(valor);
            }
          });
        },
      ),
    );
  }

  Widget _createCardHostTeam(String team, Bet bet) {
    bool typeIcon = bet.isHostWin ?? false;
    return InkWell(
      onTap: () {
        this.setState(() {
          bet.isHostWin = true;
          bet.isAwayWin = false;
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
          bet.match.requireResults
              ? _crearInput(bet, 'host')
              : Icon(typeIcon ? Icons.done_outline : Icons.clear_outlined,
                  color: typeIcon ? Colors.green : Colors.red),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Widget _createCardAwayTeam(String team, Bet bet) {
    bool typeIcon = bet.isAwayWin ?? false;

    return InkWell(
      onTap: () {
        this.setState(() {
          bet.isAwayWin = true;
          bet.isHostWin = false;
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
          bet.match.requireResults
              ? _crearInput(bet, 'away')
              : Icon(typeIcon ? Icons.done_outline : Icons.clear_outlined,
                  color: typeIcon ? Colors.green : Colors.red),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

class ApuestasPage extends StatefulWidget {
  @override
  _ApuestasPageState createState() => _ApuestasPageState();
}

class _ApuestasPageState extends State<ApuestasPage> {
  final MatchService _matchService = MatchService();

  var matchsByWeeks;

  // id del match como clave
  Map<String, Bet> bets;

  @override
  Widget build(BuildContext context) {
    //matchsByWeeks = _matchService.getMatchsByWeek();
    return _buildCards();
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
          TeamCardWidget(match, bet)
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
          mostrarAlert(
            context: context,
            title: 'Confirmacion !!!',
            text: 'Desea confirmar apuesta para esta semana?',
            onPressedOk: () async {
              /// validar que no tenga apuestas el usuario
              Navigator.of(context).pop();

              bool userHasBets = await _matchService.userHasBets();

              if (userHasBets) {
                return mostrarAlert(
                  context: context,
                  title: 'Error !!!',
                  text: 'Ya ha colocado apuesta esta semana',
                  onPressedOk: () {
                    Navigator.of(context).pop();
                  },
                );
              }

              bets.forEach((key, value) async {
                Bet bet = value;
                if (bet.match.requireResults) {
                  if (bet.localResult > bet.awayResult) {
                    bet.isHostWin = true;
                    bet.isAwayWin = false;
                  } else if (bet.localResult < bet.awayResult) {
                    bet.isAwayWin = true;
                    bet.isHostWin = false;
                  } else {
                    bet.isTie = true;
                    bet.isAwayWin = false;
                    bet.isHostWin = false;
                  }
                }

                if ((bet.isAwayWin == null && bet.isHostWin == null) ||
                    (!bet.isAwayWin && !bet.isHostWin)) {
                  return mostrarAlert(
                    context: context,
                    title: 'Error !!!',
                    text:
                        'Seleccione ganador del partido ${bet.match.awayTeam} vs ${bet.match.hostTeam}',
                    onPressedOk: () {
                      Navigator.of(context).pop();
                    },
                  );
                }

                DateTime currentTime = await NTP.now();
                if (currentTime.isAfter(bet.match.gameDate.toDate())) {
                  bets.remove(key);
                }
              });
              _matchService
                  .saveTickeBet(bets)
                  .then((value) => mostrarAlert(
                        context: context,
                        title: 'Exito !!!',
                        text: 'Apuesta confirmada',
                        onPressedOk: () {
                          Navigator.of(context).pop();
                        },
                      ))
                  .catchError((e) {
                mostrarAlert(
                  context: context,
                  title: 'Error !!!',
                  text: '${e.toString()}',
                  onPressedOk: () {
                    Navigator.of(context).pop();
                  },
                );
              });
            },
          );
        });
  }

  FutureBuilder<QuerySnapshot> _buildCards() {
    return FutureBuilder<QuerySnapshot>(
      future: _matchService.getMatchsByWeek(),
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
          result.add(_buildCurrenWeek());
          result.add(Divider());

          if (bets == null) {
            bets = Map<String, Bet>();
          }

          snapshot.data.docs.forEach((element) {
            Match m = Match.fromJson(element.data());
            Bet b = Bet(match: m);
            // si no existe agregamos la apuesta
            if (bets[element.id] == null) {
              bets[element.id] = b;
            }

            result.add(_cardTypeDouble(m, bets[element.id]));
            result.add(separator);
          });
          result.add(_crearApuestaButton());
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

  FutureBuilder<QuerySnapshot> _buildCurrenWeek() {
    return FutureBuilder<QuerySnapshot>(
      future: _matchService.getCurrentWeek('NFL'),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error al recuperar informacion'));
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
