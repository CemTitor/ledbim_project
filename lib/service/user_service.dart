import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ledbim_project/view/home_screen.dart';

import '../model/user.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();
const baseUrl = 'reqres.in';

class UserService {
  UserService();

  Future<bool> isUserAlreadyLogged() async {
    if(await storage.containsKey(key: 'email')){
      return true;
    }
    return false;

  }

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
      /// save email and password to secure storage when login
      await storage.write(key: 'email', value: email);
      await storage.write(key: 'password', value: password);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
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
    /// delete all data from secure storage when logout
    await storage.deleteAll();
  }

  Future<List<User>> getUserList() async {
    final response = await http.get(Uri.https(baseUrl,'/api/users'));
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      List<User> users = [];
      for (var item in responseJson['data']) {
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
