import 'package:estoque_app/domain/entities/produto.dart';
import 'package:estoque_app/presentation/bloc/produto_bloc.dart';
import 'package:estoque_app/presentation/bloc/produto_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdicionarProdutoPage extends StatelessWidget {
  final nomeController = TextEditingController();
  final quantidadeController = TextEditingController();
  final descricaoController = TextEditingController();

  AdicionarProdutoPage({super.key});

  void adicionarProduto(BuildContext context) {
    final nome = nomeController.text;
    final quantidade = int.tryParse(quantidadeController.text) ?? 0;
    final descricao = descricaoController.text;

    if (nome.isEmpty || quantidade <= 0) {
      return;
    }

    final produto = Produto(
      id: DateTime.now().toString(),
      nome: nome,
      quantidade: quantidade,
      descricao: descricao,
    );

    BlocProvider.of<ProdutoBloc>(context).add(AdicionarProdutoEvent(produto));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            TextField(
              controller: descricaoController,
              decoration: const InputDecoration(labelText: 'Descrição'),
              maxLines: 3,
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: ElevatedButton(
                onPressed: () => adicionarProduto(context),
                child: const Text('Adicionar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
