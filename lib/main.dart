import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'file:///C:/Users/Hermione/AndroidStudioProjects/chatapp/lib/sceens/Login_Page.dart';

import 'Socket/Cadastrar.dart';
import 'dicionario.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: primaryColor,
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            titleTextStyle: TextStyle(color: Colors.white))),
    home: LoginPage(),
  ));
  GetIt.I.registerSingleton<Cadastrar>(Cadastrar());
}
