import 'package:chat/screenss/home_screen.dart';
import 'package:chat/screenss/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constant.dart';

class AuthChat extends StatefulWidget {
  AuthChat({super.key});

  @override
  State<AuthChat> createState() => _AuthChatState();
}

class _AuthChatState extends State<AuthChat> {
  String? email;

  String? password;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _saving,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: globalKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Center(child: Image.asset("assets/images/scholar.png")),
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: Text(
                        "Scholar Chat",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (data) {
                        email = data;
                      },
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (data) {
                        password = data;
                      },
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (globalKey.currentState!.validate()) {
                            setState(() {
                              _saving = true;
                            });

                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: email!,
                                password: password!,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("success"),
                                ),
                              );
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>HomeScreen(email: email!,)), (route) => false);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      e.code.toString(),
                                    ),
                                  ),
                                );
                              } else if (e.code == 'email-already-in-use') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      e.code.toString(),
                                    ),
                                  ),
                                );
                              }
                            }

                            setState(() {
                              _saving = false;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 48),
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.blueGrey),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "don't have in account",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => RegisterScreen()));
                            },
                            child: Text("Register"))
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
