import 'package:estudos/bloc/cadastro_bloc.dart';
import 'package:estudos/models/produto.dart';
import 'package:estudos/screens/conteudo_produto.dart';
import 'package:flutter/material.dart';

class ProdutoView extends StatefulWidget {
  @override
  _ProdutoViewState createState() => _ProdutoViewState();
}

class _ProdutoViewState extends State<ProdutoView> {
  /// Cria uma funcao lista do tipo widget, map<string> do tipo produto
  List<Widget> _buildList(Map<String, List<Produto>> produtoCadastrado) {
    /// cria uma lista do tipo widget
    List<Widget> lista = List<Widget>();

    /// para cada chave e valor do produto cadastrado ele add um listTile a lista
    produtoCadastrado.forEach((key, value) {
      lista.add(
        ListTile(
          title: Text(key),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConteudoProduto(
                  listaProduto: value,
                  /// o titile é uma key para assumir o valor key.
                  title: key,
                ),
              ),
            );
          },
        ),
      );
    });

    return lista;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        ///retorna a stream do bloc
        stream: CadastroBloc.getBloc.streamListaCadastrado,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: _buildList(snapshot.data),
            );
          }
          return ListView();
        },
      ),
    );
  }
}
