import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'apiintegration.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _username = TextEditingController();
  final _senha = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Image.asset(
                      'images/logo.png',
                      width: MediaQuery.of(context).size.width * 0.65,
                      errorBuilder: (con, err, ten) {
                        return Icon(
                          Icons.error,
                          size: MediaQuery.of(context).size.height * 0.16,
                          color: Colors.grey,
                        );
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 3,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.55,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: TextFormField(
                          validator: (e) {
                            if (e!.isEmpty) return 'Preencha esse campo';
                            return null;
                          },
                          controller: _username,
                          decoration: const InputDecoration(
                            labelText: 'Usuario',
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: TextFormField(
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: true,
                          controller: _senha,
                          validator: (e) {
                            if (e!.isEmpty) return 'Preencha esse campo';
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Senha',
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 40),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => _loading = true);

                              var jwt = await attemptLogIn(
                                context,
                                username: _username.text,
                                password: _senha.text,
                              );
                              if (jwt != null) {
                                user = await getUser(jwt['token']);
                                storage.write(
                                  key: "jwt",
                                  value: jwt['token'],
                                );
                                storage.write(
                                  key: "user",
                                  value: json.encode(user),
                                );
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/mainpage',
                                );
                              }
                              setState(() => _loading = false);
                            }
                          },
                          child: const Text('ENTRAR'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_loading)
            Container(
              color: const Color(0x66666666),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
