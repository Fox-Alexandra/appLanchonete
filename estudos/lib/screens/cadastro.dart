import 'package:flutter/material.dart';
import 'package:estudos/widgets/extended_button.dart';
import 'package:estudos/bloc/produtos_bloc.dart';

class Cadastro extends StatefulWidget {
  @override
  _MercadoriaState createState() => _MercadoriaState();
}

class _MercadoriaState extends State<Cadastro> {
  ///[Form]
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Controller do campo nome
  String _mercadoriaController;

  String _tipoMercadoriaController;

  final TextEditingController _quantMercadoriaController =
      TextEditingController();

  String _lanchoneteController;

  List<DropdownMenuItem> listaMercadoria = [];

  List<DropdownMenuItem> listaTipoMercadoria = [];

  List<DropdownMenuItem> listaLanchonete = [];

  ControleLista bloc = ControleLista();

  @override
  void initState() {
    super.initState();
    _initList();
  }

  void _initList() {
    List<String> produto = [
      'Hamburgao',
      'Coxinha',
      'Coca-Cola',
      'Cerveja',
      'Agua com gás',
      'Agua sem gás',
    ];

    List<String> tipoProduto = ['Salgado', 'Assado', 'Bebida'];

    List<String> lanchonete = [
      'Marcos Freire',
      'Juscelino Kubitschek',
      'Deposito'
    ];

    List<DropdownMenuItem> addList = [];
    List<DropdownMenuItem> addTipoList = [];
    List<DropdownMenuItem> addlanchoneteList = [];

    produto.forEach((item) {
      addList.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    });

    tipoProduto.forEach((item) {
      addTipoList.add(DropdownMenuItem(
        value: item,
        child: Text(item),
      ));
    });

    lanchonete.forEach((item) {
      addlanchoneteList.add(DropdownMenuItem(
        value: item,
        child: Text(item),
      ));
    });

    setState(() {
      listaMercadoria = addList;
      listaTipoMercadoria = addTipoList;
      listaLanchonete = addlanchoneteList;
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text('Cadastro'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _buildForm(context),
            ),
            ExtendedButton(
              isLoading: false,
              onPressed: () {
                setState(() {});
                bloc.gravarAlteracaoes(
                  context,
                  nome: _mercadoriaController,
                  tipo: _tipoMercadoriaController,
                );
              },
              padding: EdgeInsets.fromLTRB(
                16,
                16,
                16,
                MediaQuery.of(context).padding.bottom > 0
                    ? MediaQuery.of(context).padding.bottom
                    : 16,
              ),
              child: Text('Cadastrar'),
            )
          ],
        ),
      ),
    );
  }

  ///[Form]
  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 39),
      child: Form(
        autovalidate: false,
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 2, left: 3, right: 3, bottom: 3),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Produto',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(1, 16, 1, 0),
                      child: DropdownButtonFormField(
                        isDense: true,
                        items: listaMercadoria,
                        onChanged: (value) {
                          setState(() {
                            _mercadoriaController = value;
                          });
                        },
                        value: _mercadoriaController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            helperText: '',
                            labelText: 'Mercadoria'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(1, 16, 1, 0),
                      child: DropdownButtonFormField(
                        isDense: true,
                        items: listaTipoMercadoria,
                        onChanged: (value) {
                          setState(() {
                            _tipoMercadoriaController = value;
                          });
                        },
                        value: _tipoMercadoriaController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            helperText: '',
                            labelText: 'Tipo'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(1, 16, 1, 0),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: _quantMercadoriaController,
                        scrollPadding: EdgeInsets.symmetric(vertical: 48),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            helperText: '',
                            labelText: 'Quantidade'),
                        onEditingComplete: () {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(1, 16, 1, 0),
                      child: DropdownButtonFormField(
                        isDense: true,
                        items: listaLanchonete,
                        onChanged: (value) {
                          setState(() {
                            _lanchoneteController = value;
                          });
                        },
                        value: _lanchoneteController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            helperText: '',
                            labelText: 'Lanchonete'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
