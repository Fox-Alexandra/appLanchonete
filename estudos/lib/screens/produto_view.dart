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

      int contadorTotal = 0;
      widget.listaProduto.forEach((item) {
        contadorTotal = contadorTotal + item.qnt;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView(
          children: _buildList(),
        ),
      ),
    );
  }
}
