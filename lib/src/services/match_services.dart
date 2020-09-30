import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:la_quiniela/src/model/bet.dart';
import 'package:ntp/ntp.dart';

class MatchService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference matchs = FirebaseFirestore.instance.collection('matchs');

  CollectionReference teams = FirebaseFirestore.instance.collection('teams');

  CollectionReference weeks = FirebaseFirestore.instance.collection('weeks');

  CollectionReference bets = FirebaseFirestore.instance.collection('bets');

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

    DateTime currentTime = await NTP.now();

    return matchs
        .where('week', isEqualTo: currWeek)
        .where('gameDate', isGreaterThanOrEqualTo: currentTime)
        .orderBy('gameDate')
        .get();
  }

  Future<DocumentReference> _saveBet(String matchId, Bet bet) async {
    DateTime currentTime = await NTP.now();
    return bets.add({
      'awayResult': bet.awayResult,
      'isAwayWin': bet.isAwayWin,
      'isBetWin': false,
      'isHostWin': bet.isHostWin,
      'isTie': bet.isTie,
      'localResult': bet.localResult,
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

  Future<DocumentReference> saveTickeBet(Map<String, Bet> apuestas) async {
    var currWeek = await currentWeekByTournamet('NFL');

    if (apuestas == null || apuestas.isEmpty) {
      throw Exception("La apuesta esta vacia");
    }

    DateTime currentTime = await NTP.now();
    return ticketBet.add({
      'week': currWeek,
      'date': currentTime,
      'userId': _auth.currentUser.uid,
    }).then((tick) {
      apuestas.forEach((key, value) {
        value.ticketBet = tick.id;
        _saveBet(key, value);
      });
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
        .get();
  }
}
