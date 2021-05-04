import 'package:chatapp/dicionario.dart';
import 'package:flutter/material.dart';

class ButtonRound extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const ButtonRound({Key key, this.text, this.onTap}) : super(key: key);

  @override
  _ButtonRoundState createState() => _ButtonRoundState();
}

class _ButtonRoundState extends State<ButtonRound> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        child: Center(
            child: Text(
          widget.text,
          style: TextStyle(fontSize: 23, color: Colors.white),
        )),
        padding: EdgeInsets.symmetric(vertical: 15),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(29),
          color: primaryColor,
        ),
      ),
    );
  }
}
