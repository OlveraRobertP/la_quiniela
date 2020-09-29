import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ntp/ntp.dart';

class MatchService {
  CollectionReference match = FirebaseFirestore.instance.collection('matchs');

  CollectionReference teams = FirebaseFirestore.instance.collection('teams');

  CollectionReference weeks = FirebaseFirestore.instance.collection('weeks');

  CollectionReference tournament =
      FirebaseFirestore.instance.collection('tournament');

  CollectionReference seasons =
      FirebaseFirestore.instance.collection('seasons');

  Future<QuerySnapshot> getCurrentWeek() async {
    var docsTourn = await tournament.where('name', isEqualTo: 'NFL').get();

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

    DateTime currentTime = await NTP.now();

    return match
        .where('week', isEqualTo: currWeek)
        .where('gameDate', isGreaterThanOrEqualTo: currentTime)
        .orderBy('gameDate')
        .get();
  }
}
