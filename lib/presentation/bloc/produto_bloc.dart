import 'package:bloc/bloc.dart';
import 'package:estoque_app/domain/entities/produto.dart';
import 'package:estoque_app/domain/respositories/produto_repository.dart';
import 'package:estoque_app/domain/usecases/adicionar_produto.dart';
import 'package:estoque_app/domain/usecases/obter_produtos.dart';
import 'package:estoque_app/presentation/bloc/produto_event.dart';
import 'package:estoque_app/presentation/bloc/produto_state.dart';

class ProdutoBloc extends Bloc<ProdutoEvent, ProdutoState> {
  final AdicionarProduto adicionarProduto;
  final ObterProdutos obterProdutos;
  final AtualizarProduto atualizarProduto;

  ProdutoBloc({
    required this.adicionarProduto,
    required this.obterProdutos,
    required this.atualizarProduto,
  }) : super(ProdutoInitial()) {
    on<AdicionarProdutoEvent>((event, emit) async {
      await adicionarProduto(event.produto);
      emit(ProdutoAdicionado());
      add(ObterProdutosEvent());
    });

    on<ObterProdutosEvent>((event, emit) async {
      emit(ProdutoCarregando());
      await Future.delayed(
        const Duration(seconds: 2),
      );

      try {
        final produtos = await obterProdutos();
        emit(ProdutoCarregado(produtos));
      } catch (e) {
        emit(ProdutoErro(e.toString()));
      }
    });

    on<AtualizarProdutoEvent>((event, emit) async {
      try {
        await atualizarProduto(event.produto);
        emit(ProdutoAtualizado());
        add(ObterProdutosEvent());
      } catch (e) {
        emit(ProdutoErro(e.toString()));
      }
    });
    add(ObterProdutosEvent());
  }

  @override
  void onTransition(Transition<ProdutoEvent, ProdutoState> transition) {
    super.onTransition(transition);
    if (transition.currentState is ProdutoInitial) {
      add(ObterProdutosEvent());
    }
  }
}

class AtualizarProduto {
  final ProdutoRepository produtoRepository;

  AtualizarProduto(this.produtoRepository);

  Future<void> call(Produto produto) async {
    await produtoRepository.atualizarProduto(produto);
  }
}
