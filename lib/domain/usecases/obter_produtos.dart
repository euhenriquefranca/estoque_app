import 'package:estoque_app/domain/entities/produto.dart';
import 'package:estoque_app/domain/respositories/produto_repository.dart';

class ObterProdutos {
  final ProdutoRepository repository;

  ObterProdutos(this.repository);

  Future<List<Produto>> call() async {
    return await repository.obterProdutos();
  }
}
