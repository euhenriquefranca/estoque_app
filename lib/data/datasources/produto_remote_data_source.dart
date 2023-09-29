import 'package:estoque_app/domain/entities/produto.dart';

abstract class ProdutoRemoteDataSource {
  Future<List<Produto>> obterProdutos();
}

class ProdutoRemoteDataSourceImpl implements ProdutoRemoteDataSource {
  @override
  Future<List<Produto>> obterProdutos() {
    // Implementar a lógica para obter produtos de uma API remota
    throw UnimplementedError();
  }
}
