import 'package:estoque_app/data/datasources/produto_local_data_source.dart';
import 'package:estoque_app/data/datasources/produto_remote_data_source.dart';
import 'package:estoque_app/domain/entities/produto.dart';
import 'package:estoque_app/domain/respositories/produto_repository.dart';

class ProdutoRepositoryImpl implements ProdutoRepository {
  final ProdutoLocalDataSource localDataSource;
  final ProdutoRemoteDataSource remoteDataSource;
  final List<Produto> _produtos = [];

  ProdutoRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<List<Produto>> obterProdutos() async {
    try {
      return await remoteDataSource.obterProdutos();
    } catch (error) {
      return await localDataSource.obterProdutos();
    }
  }

  @override
  Future<void> adicionarProduto(Produto produto) async {
    await localDataSource.adicionarProduto(produto);
  }

  @override
  Future<void> atualizarProduto(Produto produto) async {
    @override
    Future<void> atualizarProduto(Produto produto) async {
      for (int i = 0; i < _produtos.length; i++) {
        if (_produtos[i].id == produto.id) {
          _produtos[i] = produto;
          break;
        }
      }
    }
  }
}
