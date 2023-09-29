import '../entities/produto.dart';

abstract class ProdutoRepository {
  Future<List<Produto>> obterProdutos();
  Future<void> adicionarProduto(Produto produto);
  Future<void> atualizarProduto(Produto produto);
}
