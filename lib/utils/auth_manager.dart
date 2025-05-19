// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_associate/data/models/user.dart';

class AuthManager {
    
    static final ValueNotifier<String?> authChangeNotifier = ValueNotifier(null);
    static final ValueNotifier<User?> userChangeNotifier = ValueNotifier(null);
    // static final SharedPreferences _sharedPreferences  =  SharedPreferences.getInstance() as SharedPreferences;

   static Future<void> saveToken(String token) async{
    SharedPreferences prfs  = await SharedPreferences.getInstance();
    await prfs.setString('access_token', token);
    authChangeNotifier.value = token;
   }

   static void saveUser(User user) async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    await prfs.setString('user_data', jsonEncode(user.toJson()));
    userChangeNotifier.value = user;
   }

   static Future<String?> readAuth() async{
    SharedPreferences prfs  = await SharedPreferences.getInstance();
    final token = prfs.getString('access_token');
    authChangeNotifier.value = token;
    return token;
   }

   static Future<User?> readUser() async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    final userData = prfs.getString('user_data');
    if (userData != null) {
      return User.fromJson(jsonDecode(userData));
    }
    return null;
   }

   static Future<void> logout() async{
     SharedPreferences prfs  = await SharedPreferences.getInstance();
     await prfs.clear();
     authChangeNotifier.value = null;
     userChangeNotifier.value = null;
   }
   
  }