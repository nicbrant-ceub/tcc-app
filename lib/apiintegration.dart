import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64;

final storage = FlutterSecureStorage();
const String SERVER_IP = 'http://127.0.0.1:3333';

Future<String> get jwtOrEmpty async {
  var jwt = await storage.read(key: "jwt");
  if (jwt == null) return "";
  return jwt;
}

Future<Map?> attemptLogIn(
  context, {
  required String username,
  required String password,
}) async {
  try {
    var body = {
      "username": username,
      "password": password,
    };
    var res = await http.post(
      Uri.parse("$SERVER_IP/session"),
      body: json.encode(body),
      headers: {'Content-Type': "application/json"},
    );
    if (res.statusCode == 200) {
      // print(res.body);
      var cjson = json.decode(res.body);
      return cjson;
    } else {
      return null;
    }
  } catch (error) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    return null;
  }
}
