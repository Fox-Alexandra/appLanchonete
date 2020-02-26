import 'package:estudos/models/produto.dart';
import 'package:flutter/material.dart';
import 'package:estudos/widgets/extended_button.dart';
import 'package:estudos/bloc/cadastro_bloc.dart';

class Cadastro extends StatefulWidget {
  @override
  _MercadoriaState createState() => _MercadoriaState();
}

class _MercadoriaState extends State<Cadastro> {
  ///[Form]
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Controller do campo nome
  String _mercadoria;

  String _tipoMercadoria;

  String _lanchonete;

  final TextEditingController _quantMercadoriaController =
      TextEditingController();

  final FocusNode _quantMercadoriaNode = FocusNode();

  List<DropdownMenuItem> listaMercadoria = [];

  List<DropdownMenuItem> listaTipoMercadoria = [];

  List<DropdownMenuItem> listaLanchonete = [];

  bool haveError = false;

  String validate(value) {
    if (value == null || value.isEmpty) {
      if (!haveError) {
        setState(() {
          haveError = true;
        });
      }
      return 'Campo Obrigatório';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _initList();
  }

  void _initList() {
    List<String> produto = [
      'Hamburgão',
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
      'Depósito'
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
                if (_formKey.currentState.validate()) {
                  CadastroBloc.getBloc.saveCadastro(
                    Produto(
                      mercadoria: _mercadoria,
                      tipoMercadoria: _tipoMercadoria,
                      lanchonete: _lanchonete,
                      qnt: int.tryParse(_quantMercadoriaController.text),
                    ),
                  );
                  _formKey.currentState.reset();
                }
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
        autovalidate: haveError,
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
                            _mercadoria = value;
                          });
                        },
                        value: _mercadoria,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          helperText: '',
                          labelText: 'Mercadoria',
                        ),
                        validator: validate,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(1, 16, 1, 0),
                      child: DropdownButtonFormField(
                        isDense: true,
                        items: listaTipoMercadoria,
                        onChanged: (value) {
                          setState(() {
                            _tipoMercadoria = value;
                          });
                        },
                        value: _tipoMercadoria,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          helperText: '',
                          labelText: 'Tipo',
                        ),
                        validator: validate,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(1, 16, 1, 0),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.number,
                        focusNode: _quantMercadoriaNode,
                        controller: _quantMercadoriaController,
                        scrollPadding: EdgeInsets.symmetric(vertical: 48),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          helperText: '',
                          labelText: 'Quantidade',
                        ),
                        validator: validate,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(1, 16, 1, 0),
                      child: DropdownButtonFormField(
                        isDense: true,
                        items: listaLanchonete,
                        onChanged: (value) {
                          setState(() {
                            _lanchonete = value;
                          });
                        },
                        value: _lanchonete,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            helperText: '',
                            labelText: 'Lanchonete'),
                        validator: validate,
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
