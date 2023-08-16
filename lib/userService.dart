import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pawder_use_case/userModel.dart';

class UserService {

  String baseUrl = 'https://randomuser.me';

  headers() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json'
  };

  Future getRandomUser() async {
    final response = await http.get(Uri.parse("$baseUrl/api/"), headers: headers());

    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    //print(data);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return UserModel.fromJson(data);

      default:
      //throw NetworkError(response.statusCode.toString(), response.body);
    }
  }

}