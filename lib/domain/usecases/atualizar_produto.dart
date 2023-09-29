import 'package:estoque_app/domain/entities/produto.dart';
import 'package:estoque_app/domain/respositories/produto_repository.dart';

class AtualizarProduto {
  final ProdutoRepository produtoRepository;

  AtualizarProduto(this.produtoRepository);

  Future<void> call(Produto produto) async {
    await produtoRepository.atualizarProduto(produto);
  }
}
