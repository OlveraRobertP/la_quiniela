import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';

FirebaseFunctions functions = FirebaseFunctions.instance;

/*Future<void> sendNotification(String ticketId) async {
  var data = json.encode({"ticketId": ticketId});

  print("--------sendNotification---------");
  print(data);

  HttpsCallableResult results = await FirebaseFunctions.instance
      .httpsCallable('sendConfirmationBet')
      .call(data);
  // final results = await callable(data);

  print(results.data);
  print("--------sendNotificationFIn---------");
}*/

void sendNotification(String ticketId) {
  var url =
      "https://us-central1-laquiniela-1c431.cloudfunctions.net/sendConfirmationBet";
  var body = json.encode({"ticketId": ticketId});

  Map<String, String> headers = {'Content-type': 'application/json'};

  http.post(url, body: body, headers: headers);
}
