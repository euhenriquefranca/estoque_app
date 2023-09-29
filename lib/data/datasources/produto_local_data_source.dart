import 'dart:convert';
import 'package:estoque_app/domain/entities/produto.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProdutoLocalDataSource {
  Future<List<Produto>> obterProdutos();
  Future<void> adicionarProduto(Produto produto);
}

class ProdutoLocalDataSourceImpl implements ProdutoLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProdutoLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<Produto>> obterProdutos() async {
    var produtosJson = sharedPreferences.getStringList('produtos') ?? [];
    List<Produto> produtos = produtosJson
        .map((produtoJson) => Produto.fromJson(json.decode(produtoJson)))
        .toList();
    return produtos;
  }

  @override
  Future<void> adicionarProduto(Produto produto) async {
    var produtos = await obterProdutos();
    produtos.add(produto);
    var produtosJson =
        produtos.map((produto) => json.encode(produto.toJson())).toList();
    await sharedPreferences.setStringList('produtos', produtosJson);
  }
}
