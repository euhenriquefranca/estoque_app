import 'package:estoque_app/presentation/pages/produtos_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> wait() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: wait(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const ProdutosPage();
        }

        return Scaffold(
          body: Container(
            color: Colors.green,
            child: const Center(
              child: Text(
                'EstoqueApp',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
