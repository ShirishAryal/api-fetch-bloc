import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../models/user.dart';

class ApiServices {
  String endpoint = "https://jsonplaceholder.typicode.com/users";

  Future<List<User>> getUser() async {
    try {
      Response response = await get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        List<User> userList = List<User>.from(json.decode(response.body).map((x) => User.fromJson(x)));
        return userList;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } on SocketException {
      throw 'Check your internet connection and try again.';
    } //Handel further more errors and exceptions as such
  }
}
