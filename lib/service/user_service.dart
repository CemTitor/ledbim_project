import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../model/user.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class UserService {
  UserService();

  static const baseUrl = 'reqres.in';


  Future<void> register(String email, String username, String password) async {
    final response = await http.post(
      Uri.https(baseUrl, '/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode != 200) {
      throw LoginFailure();
    }
    if (kDebugMode) {
      print(response.statusCode);
      print(response.body);
    }
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    final response = await http.post(
      Uri.https(baseUrl, '/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode != 200) {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      throw LoginFailure();
    } else {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }

      await storage.write(key: 'email', value: email);
      await storage.write(key: 'password', value: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  Future<bool> checkLogin() async {
    final email = await storage.read(key: 'email');
    final password = await storage.read(key: 'password');
    if (email == null || password == null) {
      return false;
    }
    final response = await http.post(
      Uri.https(baseUrl, '/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );
    return response.statusCode == 200;
  }


  Future<void> logout() async {
    final response = await http.post(Uri.https(baseUrl, '/api/logout'));
    if (response.statusCode != 200) {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      throw LogoutFailure();
    }
    if (kDebugMode) {
      print(response.statusCode);
      print(response.body);
    }
    await storage.deleteAll();

  }

  Future<List<User>> getUserList() async {

    final response = await http.get(Uri.https(baseUrl,'/api/users'));
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      List<User> users = [];
      for (var item in responseJson['data']) {
        print("item: $item");
        users.add(User.fromJson(item));
      }
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}

class LoginFailure implements Exception {}

class LogoutFailure implements Exception {}
