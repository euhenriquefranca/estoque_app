import 'package:estoque_app/domain/entities/produto.dart';
import 'package:estoque_app/domain/respositories/produto_repository.dart';

class AdicionarProduto {
  final ProdutoRepository repository;

  AdicionarProduto(this.repository);

  Future<void> call(Produto produto) async {
    await repository.adicionarProduto(produto);
  }
}
