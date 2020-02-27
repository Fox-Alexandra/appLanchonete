import 'package:estudos/bloc/cadastro_bloc.dart';
import 'package:estudos/models/lanchonete.dart';
import 'package:estudos/models/produto.dart';
import 'package:estudos/screens/produto_view.dart';
import 'package:estudos/widgets/image_card.dart';
import 'package:flutter/material.dart';

class LanchoneteView extends StatefulWidget {
  @override
  _LanchoneteViewState createState() => _LanchoneteViewState();
}

class _LanchoneteViewState extends State<LanchoneteView> {
  /// Cria uma funcao lista do tipo widget, map<string> do tipo produto
  List<Widget> _buildList(Map<Lanchonete, List<Produto>> produtoCadastrado) {
    /// cria uma lista do tipo widget (lista auxilixar)
    List<Widget> listaAux = List<Widget>();

    /// para cada chave e valor do produto cadastrado ele add um listTile a listaAux
    produtoCadastrado.forEach((key, value) {
      listaAux.add(
        ListTile(
          title: Padding(
            padding: EdgeInsets.only(top:10),
          child: ImageCard( 
            title: key.lanchonete,
            image: key.image,
            onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdutoView(
                  listaProduto: value,
                  title: key.lanchonete,
                ),
              ),
            );
          },
          ),
        ),
        ),
      );
    });

    return listaAux;
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
