import 'package:flutter/material.dart';

class PageItemCardapio extends StatefulWidget {
  final Map itemcalendario;

  const PageItemCardapio({Key? key, required this.itemcalendario})
      : super(key: key);

  @override
  State<PageItemCardapio> createState() => _PageItemCardapioState();
}

class _PageItemCardapioState extends State<PageItemCardapio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.itemcalendario['title']}'),
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListView(
          children: const [],
        ),
      ),
    );
  }
}
