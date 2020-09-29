import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:la_quiniela/src/model/week.dart';

class Match {
  String hostTeam;
  String awayTeam;
  Week week;
  bool requireResults;
  String placeGameName;
  Timestamp gameDate;

  Match({
    this.week,
    this.awayTeam,
    this.gameDate,
    this.hostTeam,
    this.placeGameName,
    this.requireResults,
  });

  Match.fromJson(Map parsedJson) {
    awayTeam = parsedJson['awayTeam'];
    gameDate = parsedJson['gameDate'];
    hostTeam = parsedJson['hostTeam'];
    placeGameName = parsedJson['placeGameName'];
    requireResults = parsedJson['requireResults'];
  }
}
