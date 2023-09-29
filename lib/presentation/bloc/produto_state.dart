import 'package:equatable/equatable.dart';
import 'package:estoque_app/domain/entities/produto.dart';

abstract class ProdutoState extends Equatable {
  const ProdutoState();

  @override
  List<Object> get props => [];
}

class ProdutoInitial extends ProdutoState {}

class ProdutoCarregando extends ProdutoState {}

class ProdutoCarregado extends ProdutoState {
  final List<Produto> produtos;

  const ProdutoCarregado(this.produtos);

  @override
  List<Object> get props => [produtos];
}

class ProdutoAdicionado extends ProdutoState {}

class ProdutoAtualizado extends ProdutoState {}

class ProdutoErro extends ProdutoState {
  final String mensagem;

  const ProdutoErro(this.mensagem);

  @override
  List<Object> get props => [mensagem];
}
