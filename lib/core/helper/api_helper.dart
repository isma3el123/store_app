import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_app/core/utils/cached_network.dart';

class Api {
  Future<dynamic> get({required String url}) async {
    final token = await SharedPreferencesHelper.getToken();

    if (token.isEmpty) {
      throw Exception('Token is missing or invalid.');
    }

    try {
      Map<String, String> headers = {'Authorization': 'Bearer $token'};
      http.Response response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('There is a problem: ${e.toString()}');
      return null;
    }
  }
}
