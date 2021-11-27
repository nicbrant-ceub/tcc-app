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
        title: Text('${widget.itemcalendario['name'] ?? ''}'),
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.network(
                widget.itemcalendario['image_url'],
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                fit: BoxFit.fitWidth,
                errorBuilder: (con, err, ten) {
                  return Icon(
                    Icons.error,
                    size: MediaQuery.of(context).size.height * 0.16,
                    color: Colors.grey,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Preço:    '),
                      Flexible(
                        child:
                            Text('R\$ ${widget.itemcalendario['value'] ?? ''}'),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('Descrição:'),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Flexible(
                          child: Text(
                              '${widget.itemcalendario['description'] ?? ''}'),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('Categoria:'),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Flexible(
                          child: Text(
                              '${(widget.itemcalendario['sub_category'] != null ? widget.itemcalendario['sub_category']['name'] : null) ?? ''}'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
