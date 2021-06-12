import 'dart:async';
import 'dart:typed_data';

import 'package:chatapp/Socket/Cadastrar.dart';
import 'package:chatapp/dicionario.dart';
import 'package:chatapp/widgets/ButtonRound.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  static const platform = const MethodChannel("cadastrar");
  Uint8List image;
  TextEditingController nomeText = TextEditingController();
  TextEditingController emailText = TextEditingController();
  TextEditingController senhaText = TextEditingController();
  bool cadastrando = false;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler((call) {
      if (call.method == "result") {
        print(call.arguments);
        setState(() {
          cadastrando = false;
        });
        return null;
      } else
        return null;
    });
  }

  Future<void> TakePictureGalery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) image = await pickedFile.readAsBytes();
    setState(() {});
  }

  Future<void> TakePictureCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) image = await pickedFile.readAsBytes();

    setState(() {});
  }

  Widget iosMenu(context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
            onPressed: () async {
              TakePictureCamera();
              Navigator.pop(context);
            },
            child: Text(
              'camera',
              style: TextStyle(color: Colors.deepPurple),
            )),
        CupertinoActionSheetAction(
            onPressed: () {
              TakePictureGalery();
              Navigator.pop(context);
            },
            child: Text(
              'galeria',
              style: TextStyle(color: Colors.deepPurple),
            )),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          "cancelar",
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return !cadastrando
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                "Cadastrar",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            width: 280,
                            height: 280,
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.black,
                              backgroundImage: image != null
                                  ? Image.memory(image).image
                                  : AssetImage('lib/assets/semfoto.jpeg'),
                              radius: 25.0,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: MaterialButton(
                              color: primaryColor,
                              onPressed: () async {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => iosMenu(context));
                              },
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 30,
                              ),
                              padding: EdgeInsets.all(18),
                              shape: CircleBorder(),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(29),
                            color: primaryColorLight,
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          margin:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                          child: TextField(
                            controller: nomeText,
                            cursorColor: Colors.deepPurple,
                            style: TextStyle(fontSize: 21),
                            decoration: InputDecoration(
                                icon: Icon(Icons.person),
                                border: InputBorder.none,
                                hintText: "Nome"),
                          )),
                      Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(29),
                            color: primaryColorLight,
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          margin: EdgeInsets.all(25),
                          child: TextField(
                            controller: emailText,
                            cursorColor: Colors.deepPurple,
                            style: TextStyle(fontSize: 21),
                            decoration: InputDecoration(
                                icon: Icon(Icons.email),
                                border: InputBorder.none,
                                hintText: "e-mail"),
                          )),
                      Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(29),
                            color: primaryColorLight,
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          child: TextField(
                            controller: senhaText,
                            obscureText: true,
                            cursorColor: Colors.deepPurple,
                            style: TextStyle(fontSize: 21),
                            decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                border: InputBorder.none,
                                hintText: "senha"),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 90),
                        child: ButtonRound(
                          text: "cadastrar",
                          onTap: () async {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());

                            Cadastrar.cadastrar({
                              "nome": nomeText.text,
                              "email": emailText.text,
                              "senha": senhaText.text,
                              "foto": image == null ? null : image
                            });
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Já tem conta?",
                            style: TextStyle(color: primaryColor, fontSize: 15),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "logar",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container(
            color: Colors.white,
            child: Center(
              child: Container(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                  )),
            ),
          );
  }
}
