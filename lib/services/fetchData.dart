import 'dart:convert';
import 'package:easyku_app/models/ResultList.dart';
import 'package:http/http.dart' as http;


Future<List<ResultListWithDate>> fetchData(String apiUrl) async {
  var response = await http.get(apiUrl);
  List rsList = json.decode(response.body);
  return rsList.map((e) => ResultListWithDate.fromJson(e)).toList();
}

Future<List<ResultListWithDate>> fetchNotifications() async {
  return fetchData('https://kerala-university-api.herokuapp.com/notifications');
}

Future<List<ResultListWithDate>> fetchResults() async {
  return fetchData('https://kerala-university-api.herokuapp.com');
}