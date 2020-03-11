import 'package:estudos/config/produto_config.dart';
import 'package:estudos/config/lanchonete_config.dart';
import 'package:estudos/models/identificacao_produto.dart';
import 'package:estudos/models/lanchonete.dart';
import 'package:estudos/models/produto.dart';
import 'package:flutter/material.dart';
import 'package:estudos/widgets/extended_button.dart';
import 'package:estudos/bloc/cadastro_bloc.dart';

class Cadastro extends StatefulWidget {
  final Produto produto;

  /// Constructor
  Cadastro({
    this.produto,
  });

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  /// Craido key para controlar o estado do [Form]
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  IdentificacaoProduto _mercadoria;

  IdentificacaoProduto _tipoMercadoria;

  Lanchonete _lanchonete;

  /// controller do campo de quantidade
  final TextEditingController _quantMercadoriaController =
      TextEditingController();

  /// Foco do campo quantidade
  final FocusNode _quantMercadoriaNode = FocusNode();

  /// Lista do tipo Drop
  List<DropdownMenuItem> listaMercadoria = [];

  List<DropdownMenuItem> listaTipoMercadoria = [];

  List<DropdownMenuItem> listaLanchonete = [];

  bool haveError = false;

  ///Validacao dos campos
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

    /// Para as variaveis inicializarem com os valores dos campos que estou editando
    if (widget.produto != null) {
      _mercadoria = widget.produto.mercadoria;
      _lanchonete = widget.produto.lanchonete;
      _tipoMercadoria = widget.produto.tipoMercadoria;
      _quantMercadoriaController.text = widget.produto.qnt.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _quantMercadoriaController.clear();
    listaLanchonete.clear();
    listaMercadoria.clear();
    listaTipoMercadoria.clear();
  }

  /*Inicializacao da lista de 
  **[Mercadoria]
  **[TipoProduto]
  **[Lanchonete]
  */
  void _initList() {
    /// Lista auxiliar para armazenar os valores
    List<DropdownMenuItem> addList = [];
    List<DropdownMenuItem> addTipoList = [];
    List<DropdownMenuItem> addlanchoneteList = [];

    ///Percorre cada item da lista monstrando-o
    produto.forEach((item) {
      addList.add(DropdownMenuItem(
        child: Text(item.nomeMercadoria),
        value: item,
      ));
    });

    tipoProduto.forEach((item) {
      addTipoList.add(DropdownMenuItem(
        value: item,
        child: Text(item.tipoMercadoria),
      ));
    });

    lanchonetes.forEach((item) {
      addlanchoneteList.add(DropdownMenuItem(
        value: item,
        child: Text(item.lanchonete),
      ));
    });

    /// adiciona o valor da lista auxiliar á lista fixa
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
                /// Se a validacao estiver ok ele cadastra
                if (_formKey.currentState.validate()) {
                  CadastroBloc.getBloc.saveCadastro(
                    Produto(
                      mercadoria: _mercadoria,
                      tipoMercadoria: _tipoMercadoria,
                      lanchonete: _lanchonete,
                      qnt: int.tryParse(_quantMercadoriaController.text),
                    ),
                    context,
                  );
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
              child: Text(
                'Cadastrar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///[Form]
  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 15),
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
                        items: listaTipoMercadoria,
                        onChanged: (value) {
                          setState(() {
                            _tipoMercadoria = value;
                          });
                        },

                        ///Declaro como um value, pois a variavel nao é um controller
                        value: _tipoMercadoria,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          helperText: '',
                          labelText: 'Tipo',
                        ),
                        validator: (value) {
                          return validate(value.tipoMercadoria);
                        },
                      ),
                    ),
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
                          validator: (value) {
                            return validate(value.nomeMercadoria);
                          }),
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
                          validator: (value) {
                            return validate(value.lanchonete);
                          }),
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
