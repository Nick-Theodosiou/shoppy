import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import 'models/User.dart';

var localUser;

var settings = ConnectionSettings(
    host: '45.84.205.255',
    port: 3306,
    user: 'u274018054_admin',
    password: 'Test123@!',
    db: 'u274018054_testDB');

Future<bool> checkCredentials(String email, String password) async {
  var conn = await MySqlConnection.connect(settings);

  var results = await conn.query(
      'select COUNT(*) from systemUser as S join LoginDetails as L on S.UserID=L.UserID where S.Email = ? AND L.Password = ?',
      [email, password]);

  if (results.first[0] == 0) return false;
  return true;
}

Future<User> getAccountDataDB(String email) async {
  var conn = await MySqlConnection.connect(settings);

  var results = await conn.query(
      'select S.UserID, S.Name, S.Surname, S.Email from systemUser as S where S.Email = ?',
      [email]);

  var user = User(
      results.first[0], results.first[1], results.first[2], results.first[3]);
  localUser = user;
  return user;
}
