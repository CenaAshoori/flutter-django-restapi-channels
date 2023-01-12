import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:web_socket/view/note/models/note_model.dart';
// import 'package:web_socket_channel/';
// import 'package:web_socket_channel/utility/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<SharedPreferences> pref = SharedPreferences.getInstance();
// add login token after sending username and password to server and get that token
Future<String> get_login_token() async {
  return await pref.then((value) {
    return value.getString('login_token')! != null
        ? value.getString('login_token')!
        : "";
  });
}

// set login token for future request that gonna be sent
Future<bool> set_login_token(String token) async {
  return await pref.then((value) async {
    return await value.setString("login_token", token);
  });
}

// For deleteing login token for any reason like log out
Future<bool> delete_login_token() async {
  return await pref.then((value) async {
    // after log out of the account. category storage should be delete.
    return await value.remove("login_token");
  });
}

const URL = "http://127.0.0.1:8000";
final token = 'c3c7658180f5f6767818849b960f6241544e01f5';

class ApiNote {
  Future<List<Note>> get_all_notes() async {
    // String token = await get_login_token();
    final url = Uri.parse('$URL/note/all/');
    final header = <String, String>{
      "Content-Type": "application/json",
    };
    if (token != null) header["Authorization"] = "Token $token";
    final response =
        await http.get(url, headers: header).onError((error, stackTrace) {
      throw Exception(error..toString());
    });
    final data = json.decode(utf8.decode(response.bodyBytes));
    return data.map<Note>((json) => Note.fromJson(json)).toList();
    // List data = json.decode(response.body);
  }

  Future<List<Note>> get_note(
    int pk,
  ) async {
    // String token = await get_login_token();
    final url = Uri.parse('$URL/note/get/$pk');
    final header = <String, String>{
      "Content-Type": "application/json",
    };
    if (token != null) header["Authorization"] = "Token $token";
    final response =
        await http.get(url, headers: header).onError((error, stackTrace) {
      throw Exception(error..toString());
    });
    final data = json.decode(utf8.decode(response.bodyBytes));
    return data.map<Note>((json) => Note.fromJson(json)).toList();
    // List data = json.decode(response.body);
  }
}
