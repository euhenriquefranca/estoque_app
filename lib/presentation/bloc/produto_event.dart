import 'package:equatable/equatable.dart';
import 'package:estoque_app/domain/entities/produto.dart';

abstract class ProdutoEvent extends Equatable {
  const ProdutoEvent();

  @override
  List<Object> get props => [];
}

class AdicionarProdutoEvent extends ProdutoEvent {
  final Produto produto;

  const AdicionarProdutoEvent(this.produto);

  @override
  List<Object> get props => [produto];
}

class AtualizarProdutoEvent extends ProdutoEvent {
  final Produto produto;

  const AtualizarProdutoEvent(this.produto);
}

class ObterProdutosEvent extends ProdutoEvent {}
