import 'package:estudos/config/produto_config.dart';
import 'package:estudos/models/produto.dart';
import 'package:flutter/material.dart';

class ProdutoView extends StatefulWidget {
  final List<Produto> listaProduto;
  final String title;
  ProdutoView({this.listaProduto, this.title});

  @override
  _ConteudoProdutoState createState() => _ConteudoProdutoState();
}

class _ConteudoProdutoState extends State<ProdutoView> {
  List<Widget> _buildList() {
    /// Retorna um valor map(lista) da lista produto
    return produto.map((value) {
      int contador = 0;
      widget.listaProduto.forEach((item) {
        if (value.idMercadoria == item.mercadoria.idMercadoria) {
          contador = contador + item.qnt;
        }
      });

      return Container(
        height: 120,
        padding: EdgeInsets.only(top: 10),
        child: InputDecorator(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
          ),
          child: ListTile(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  value.nomeMercadoria,
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40),
                ),
                Text(
                  '${contador}',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildTotal() {
    int contadorTotal = 0;
    widget.listaProduto.forEach((item) {
      contadorTotal = contadorTotal + item.qnt;
    });

    return Container(
      child: InputDecorator(
        expands: true,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Total',
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '=',
              style: TextStyle(
                fontSize: 26,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${contadorTotal}',
              style: TextStyle(
                fontSize: 26,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.35,
            child: ListView(
              children: _buildList(),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 9,
            color: Colors.lightGreen,
            child: _buildTotal(),
          ),
        ],
      ),
    );
  }
}
