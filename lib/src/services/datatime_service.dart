import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<DateTime> Now() async {
  var response = await http.get('https://worldtimeapi.org/api/ip');
  var jsonResponse = convert.jsonDecode(response.body);
  // return DateTime.parse(jsonResponse['datetime']);
  return DateTime.parse(jsonResponse['utc_datetime']);
}
