import 'package:flutter/material.dart';
import 'pagelogin.dart';
import 'pagemain.dart';
import 'pagecardapio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  final Color red = Colors.red[700] ?? Colors.red;
  final Color grey = Colors.grey[700] ?? Colors.grey;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      ),
      home: const MyHomePage(),
      routes: {
        '/login': (context) => const Login(),
        '/mainpage': (context) => const MainPage(),
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'Eat Fast',
              style: TextStyle(fontSize: 40),
            ),
            Image.asset(
              'images/logo.png',
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: MediaQuery.of(context).size.longestSide * 0.14,
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.80, 40),
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
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.80, 40),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Entrar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
