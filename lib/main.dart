import 'package:estoque_app/data/datasources/produto_local_data_source.dart';
import 'package:estoque_app/data/datasources/produto_remote_data_source.dart';
import 'package:estoque_app/data/repositories/produto_repository_impl.dart';
import 'package:estoque_app/domain/respositories/produto_repository.dart';
import 'package:estoque_app/domain/usecases/adicionar_produto.dart';
import 'package:estoque_app/domain/usecases/obter_produtos.dart';
import 'package:estoque_app/presentation/bloc/produto_bloc.dart';
import 'package:estoque_app/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  final ProdutoRepository produtoRepository = ProdutoRepositoryImpl(
    localDataSource:
        ProdutoLocalDataSourceImpl(sharedPreferences: sharedPreferences),
    remoteDataSource: ProdutoRemoteDataSourceImpl(),
  );

  final adicionarProduto = AdicionarProduto(produtoRepository);
  final obterProdutos = ObterProdutos(produtoRepository);

  runApp(MyApp(
    adicionarProduto: adicionarProduto,
    obterProdutos: obterProdutos,
    produtoRepository: produtoRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AdicionarProduto adicionarProduto;
  final ObterProdutos obterProdutos;
  final ProdutoRepository produtoRepository;

  const MyApp(
      {Key? key,
      required this.adicionarProduto,
      required this.obterProdutos,
      required this.produtoRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Estoque',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<ProdutoBloc>(
        create: (context) => ProdutoBloc(
          adicionarProduto: adicionarProduto,
          obterProdutos: obterProdutos,
          atualizarProduto: AtualizarProduto(produtoRepository),
        ),
        child: const SplashScreen(),
      ),
    );
  }
}
