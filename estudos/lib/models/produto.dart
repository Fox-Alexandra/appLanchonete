import 'identificacao_produto.dart';
import 'lanchonete.dart';

class Produto {
  Produto({
    this.mercadoria,
    this.tipoMercadoria,
    this.lanchonete,
    this.qnt,
  });

  final IdentificacaoProduto mercadoria;
  final IdentificacaoProduto tipoMercadoria;
  final Lanchonete lanchonete;
  final int qnt;
}