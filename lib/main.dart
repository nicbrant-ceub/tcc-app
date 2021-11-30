import 'package:flutter/material.dart';
import 'pagelogin.dart';
import 'pagemain.dart';
import 'apiintegration.dart';
import 'pagecardapio.dart';
import 'pagecreatereserves.dart';
import 'dart:convert' show json, base64, ascii;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  final Color red = Colors.red[700] ?? Colors.red;
  final Color grey = Colors.grey[700] ?? Colors.grey;
  final homepage = const MyHomePage();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey,
          colorScheme: ColorScheme(
            background: Colors.grey,
            brightness: Brightness.light,
            error: Colors.blue,
            onBackground: grey,
            onError: Colors.black,
            onPrimary: Colors.red,
            onSecondary: Colors.white,
            onSurface: Colors.black,
            primary: Colors.white,
            primaryVariant: red,
            secondary: Colors.red,
            secondaryVariant: Colors.red,
            surface: Colors.grey,
          ),
          textTheme: TextTheme(
            bodyText2: TextStyle(
              color: red,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            showUnselectedLabels: false,
            backgroundColor: Colors.red,
          )),
      home: FutureBuilder(
        future: jwtOrEmpty,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data != "") {
            var str = snapshot.data.toString();
            var jwt = str.split(".");

            if (jwt.length != 3) {
              return homepage;
            } else {
              var payload = json.decode(
                  ascii.decode(base64.decode(base64.normalize(jwt[1]))));
              // print(payload);
              if (DateTime.fromMillisecondsSinceEpoch(
                      (payload["iat"] + 3600 * 24 * 7) * 1000)
                  .isAfter(DateTime.now())) {
                return const MainPage();
              } else {
                return homepage;
              }
            }
          } else {
            return homepage;
          }
        },
      ),
      routes: {
        '/login': (context) => const Login(),
        '/mainpage': (context) => const MainPage(),
        '/first': (context) => const MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white,
              Colors.red,
            ],
          ),
        ),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Eat Fast',
              style: TextStyle(fontSize: 40),
            ),
            Image.asset(
              'images/logo.png',
              width: MediaQuery.of(context).size.width * 0.6,
              errorBuilder: (con, err, ten) {
                return Icon(
                  Icons.error,
                  size: MediaQuery.of(context).size.height * 0.16,
                  color: Colors.grey,
                );
              },
            ),
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.longestSide * 0.14,
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.80, 40),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PageCardapio(),
                        ),
                      );
                    },
                    child: const Text('Cardapio'),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.longestSide * 0.14,
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.80, 40),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateReservePage(),
                        ),
                      );
                    },
                    child: const Text('Reserva'),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.longestSide * 0.14,
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.80, 40),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text('Entrar'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
