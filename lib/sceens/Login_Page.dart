import 'package:chatapp/dicionario.dart';
import 'package:chatapp/sceens/CadastroPage.dart';
import 'package:chatapp/widgets/ButtonRound.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29),
                color: primaryColorLight,
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 25),
              margin: EdgeInsets.all(25),
              child: TextField(
                cursorColor: Colors.deepPurple,
                style: TextStyle(fontSize: 25),
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  border: InputBorder.none,
                  hintText: "e-mail",
                ),
              )),
          Container(
              alignment: Alignment.center,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29),
                color: primaryColorLight,
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 25),
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                obscureText: true,
                cursorColor: Colors.white,
                style: TextStyle(fontSize: 25),
                decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    border: InputBorder.none,
                    hintText: "senha"),
              )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ButtonRound(
              text: "login",
              onTap: () {},
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "não tem uma conta ainda?",
                style: TextStyle(color: primaryColor, fontSize: 15),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CadastroPage()));
                },
                child: Text(
                  "cadastrar",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
