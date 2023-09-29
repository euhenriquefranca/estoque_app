import 'package:estoque_app/presentation/bloc/produto_bloc.dart';
import 'package:estoque_app/presentation/bloc/produto_event.dart';
import 'package:estoque_app/presentation/bloc/produto_state.dart';
import 'package:estoque_app/presentation/pages/adicionar_produto_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProdutosPage extends StatelessWidget {
  const ProdutosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<ProdutoBloc>(context, listen: false)
                  .add(ObterProdutosEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder<ProdutoBloc, ProdutoState>(
        builder: (context, state) {
          if (state is ProdutoCarregando) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProdutoCarregado) {
            return ListView.builder(
              itemCount: state.produtos.length,
              itemBuilder: (ctx, i) => Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: CircleAvatar(
                    child: FittedBox(
                        child: Text('\$${state.produtos[i].quantidade}')),
                  ),
                  title: Text(state.produtos[i].nome),
                  subtitle: Text(
                      'Descrição: ${state.produtos[i].descricao ?? "N/A"}'),
                ),
              ),
            );
          } else if (state is ProdutoErro) {
            return Center(child: Text(state.mensagem));
          } else {
            return const Center(
                child: Text('Pressione o botão para carregar produtos.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (newContext) => BlocProvider.value(
                value: BlocProvider.of<ProdutoBloc>(context, listen: false),
                child: AdicionarProdutoPage(),
              ),
            ),
          );
        },
      ),
    );
  }
}
