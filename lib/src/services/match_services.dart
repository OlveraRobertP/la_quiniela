import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:la_quiniela/src/model/bet.dart';
import 'package:la_quiniela/src/model/resultados.dart';
import 'package:la_quiniela/src/services/send_notification.dart';

import 'datatime_service.dart';

class MatchService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference matchs = FirebaseFirestore.instance.collection('matchs');

  CollectionReference teams = FirebaseFirestore.instance.collection('teams');

  CollectionReference weeks = FirebaseFirestore.instance.collection('weeks');

  CollectionReference bets = FirebaseFirestore.instance.collection('bets');

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  CollectionReference ticketBet =
      FirebaseFirestore.instance.collection('ticketBet');

  CollectionReference tournament =
      FirebaseFirestore.instance.collection('tournament');

  CollectionReference seasons =
      FirebaseFirestore.instance.collection('seasons');

  Future<QuerySnapshot> getCurrentWeek(String tour) async {
    var docsTourn = await tournament.where('name', isEqualTo: tour).get();

    var docsSeason = await seasons
        .where('isCurrent', isEqualTo: true)
        .where('tournament', isEqualTo: docsTourn.docs.first.reference)
        .get();

    return weeks
        .where('isCurrent', isEqualTo: true)
        .where('season', isEqualTo: docsSeason.docs.first.reference)
        .get();
  }

  Future<QuerySnapshot> getMatchsByWeek() async {
    var currWeek = await currentWeekByTournamet('NFL');

    // DateTime currentTime = await NTP.now();
    // DateTime currentTime = DateTime.now();
    DateTime currentTime = await Now();
    return matchs
        .where('week', isEqualTo: currWeek)
        .where('gameDate', isGreaterThanOrEqualTo: currentTime)
        .orderBy('gameDate')
        .get();
  }

  Future<DocumentReference> _saveBet(String matchId, Bet bet) async {
    // DateTime currentTime = await NTP.now();
    // DateTime currentTime = DateTime.now();
    DateTime currentTime = await Now();
    return bets.add({
      'awayResult': bet.awayResult ?? 0.0,
      'isAwayWin': bet.isAwayWin,
      'isBetWin': false,
      'isHostWin': bet.isHostWin,
      'isTie': bet.isTie ?? false,
      'localResult': bet.localResult ?? 0.0,
      'userId': _auth.currentUser.uid,
      'date': currentTime,
      'ticketBet': bet.ticketBet,
      'match': matchs.doc(matchId)
    });
  }

  Future<DocumentReference> currentWeekByTournamet(String tour) async {
    var docsTourn = await tournament.where('name', isEqualTo: tour).get();

    var docsSeason = await seasons
        .where('isCurrent', isEqualTo: true)
        .where('tournament', isEqualTo: docsTourn.docs.first.reference)
        .get();

    var docsWeek = await weeks
        .where('isCurrent', isEqualTo: true)
        .where('season', isEqualTo: docsSeason.docs.first.reference)
        .get();

    return docsWeek.docs.first.reference;
  }

  Future<DocumentReference> saveTickeBet() async {
    var currWeek = await currentWeekByTournamet('NFL');

    // DateTime currentTime = await NTP.now();
    // DateTime currentTime = DateTime.now();
    DateTime currentTime = await Now();
    return ticketBet.add({
      'week': currWeek,
      'date': currentTime,
      'userId': _auth.currentUser.uid,
    });
  }

  void saveBetsByTicket(Map<String, Bet> apuestas, String ticketId) {
    if (apuestas == null || apuestas.isEmpty) {
      throw Exception("La apuesta esta vacia");
    }

    apuestas.forEach((key, value) {
      value.ticketBet = ticketId;
      _saveBet(key, value);
    });
  }

  Future<bool> userHasBets() async {
    var docsTourn = await tournament.where('name', isEqualTo: 'NFL').get();

    var docsSeason = await seasons
        .where('isCurrent', isEqualTo: true)
        .where('tournament', isEqualTo: docsTourn.docs.first.reference)
        .get();

    var docsWeek = await weeks
        .where('isCurrent', isEqualTo: true)
        .where('season', isEqualTo: docsSeason.docs.first.reference)
        .get();

    var currWeek = docsWeek.docs.first.reference;

    var ticketsByUser = await ticketBet
        .where('week', isEqualTo: currWeek)
        .where('userId', isEqualTo: _auth.currentUser.uid)
        .get();

    return ticketsByUser.docs.isNotEmpty;
  }

  Future<QuerySnapshot> getBetsByUserByWeek(String tourna, String week) async {
    if (week == null || tournament == null) return null;

    var docsTourn = await tournament.where('name', isEqualTo: tourna).get();

    var docsSeason = await seasons
        .where('isCurrent', isEqualTo: true)
        .where('tournament', isEqualTo: docsTourn.docs.first.reference)
        .get();

    var docsWeek = await weeks
        .where('description', isEqualTo: week)
        .where('season', isEqualTo: docsSeason.docs.first.reference)
        .get();

    if (docsWeek.docs.isEmpty) return null;

    var currBet = await ticketBet
        .where('week', isEqualTo: docsWeek.docs.first.reference)
        .where('userId', isEqualTo: _auth.currentUser.uid)
        .get();

    if (currBet.docs.isEmpty) return null;

    return bets
        .where('ticketBet', isEqualTo: currBet.docs.first.reference.id)
        .get();
  }

  Future<QuerySnapshot> getWeeksByTournament(String tourna) async {
    var docsTourn = await tournament.where('name', isEqualTo: tourna).get();

    var docsSeason = await seasons
        .where('isCurrent', isEqualTo: true)
        .where('tournament', isEqualTo: docsTourn.docs.first.reference)
        .get();

    return weeks
        .where('season', isEqualTo: docsSeason.docs.first.reference)
        .orderBy('description')
        .get();
  }

  Future<QuerySnapshot> getMatchByWeek(String week) async {
    DateTime currentTime = await Now();
    var weekSeason = await weeks.doc(week).get();

    return matchs
        .where('week', isEqualTo: weekSeason.reference)
        .where('gameDate', isLessThanOrEqualTo: currentTime)
        .get();
  }

  Future<List<Resultados>> getResultsTickeBetsByWeek(
      String tourna, String week) async {
    var docsTourn = await tournament.where('name', isEqualTo: tourna).get();

    var docsSeason = await seasons
        .where('isCurrent', isEqualTo: true)
        .where('tournament', isEqualTo: docsTourn.docs.first.reference)
        .get();

    var docsWeek = await weeks
        .where('description', isEqualTo: week)
        .where('season', isEqualTo: docsSeason.docs.first.reference)
        .get();

    if (docsWeek.docs.isEmpty) return null;

    var tickets = await ticketBet
        .where('week', isEqualTo: docsWeek.docs.first.reference)
        .orderBy('totalRights', descending: true)
        .get();
    try {
      List<Resultados> res = List<Resultados>();
      List<Resultados> resultados = List<Resultados>();

      tickets.docs.forEach((element) {
        res.add(Resultados(
            element.data()['userId'], element.data()['totalRights']));
      });

      for (var item in res) {
        DocumentSnapshot u = await this._getUserByUID(item.user);
        if (u != null && u.data() != null && u.data()['correo'] != null) {
          item.user = u.data()['correo'];
        }
        resultados.add(item);
      }

      return resultados;
    } catch (e) {
      print(e);
    }
  }

  Future<List<ApuestasPorPartido>> getApuestasByMatch(String match) async {
    var docsMatch = await matchs.doc(match).get();

    var tickets =
        await bets.where('match', isEqualTo: docsMatch.reference).get();
    try {
      List<ApuestasPorPartido> res = List<ApuestasPorPartido>();
      List<ApuestasPorPartido> resultados = List<ApuestasPorPartido>();
      String ganador = 'Empate';

      tickets.docs.forEach((element) {
        ganador = 'Empate';
        if (element.data()['isAwayWin']) {
          ganador = docsMatch.data()['awayTeam'];
        } else if (element.data()['isHostWin']) {
          ganador = docsMatch.data()['hostTeam'];
        }

        res.add(ApuestasPorPartido(element.data()['userId'], ganador));
      });

      for (var item in res) {
        DocumentSnapshot u = await this._getUserByUID(item.user);
        if (u != null && u.data() != null && u.data()['correo'] != null) {
          item.user = u.data()['correo'];
        }
        resultados.add(item);
      }

      return resultados;
    } catch (e) {
      print(e);
    }
  }

  Future<DocumentSnapshot> _getUserByUID(String uid) async {
    return users.doc(uid).get();
  }
}
