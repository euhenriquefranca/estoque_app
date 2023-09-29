class Produto {
  final String id;
  final String nome;
  final int quantidade;
  final String? descricao;

  Produto(
      {required this.id,
      required this.nome,
      required this.quantidade,
      this.descricao});

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'],
      nome: json['nome'],
      quantidade: json['quantidade'],
      descricao: json['descricao'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'quantidade': quantidade,
      'descricao': descricao,
    };
  }
}
