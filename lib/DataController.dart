import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

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
