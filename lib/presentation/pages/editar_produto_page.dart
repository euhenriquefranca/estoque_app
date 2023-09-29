import 'package:estoque_app/presentation/bloc/produto_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:estoque_app/domain/entities/produto.dart';
import 'package:estoque_app/presentation/bloc/produto_bloc.dart';

class EditarProdutoPage extends StatelessWidget {
  final Produto produto;
  final nomeController;
  final quantidadeController;
  final descricaoController;

  EditarProdutoPage({super.key, required this.produto})
      : nomeController = TextEditingController(text: produto.nome),
        quantidadeController =
            TextEditingController(text: produto.quantidade.toString()),
        descricaoController = TextEditingController(text: produto.descricao);

  void editarProduto(BuildContext context) {
    final nome = nomeController.text;
    final quantidade = int.tryParse(quantidadeController.text) ?? 0;
    final descricao = descricaoController.text;

    if (nome.isEmpty || quantidade <= 0) {
      // mostrar uma mensagem de erro
      return;
    }

    final produtoAtualizado = Produto(
      id: produto.id,
      nome: nome,
      quantidade: quantidade,
      descricao: descricao,
    );

    BlocProvider.of<ProdutoBloc>(context)
        .add(AtualizarProdutoEvent(produtoAtualizado));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome do Produto'),
            ),
            TextField(
              controller: quantidadeController,
              decoration: const InputDecoration(labelText: 'Quantidade'),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            TextField(
              controller: descricaoController,
              decoration: const InputDecoration(labelText: 'Descrição'),
              maxLines: 3,
            ),
            ElevatedButton(
              onPressed: () => editarProduto(context),
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
