class ClientModel {
  String chaveLiberacao;
  String cnpj;
  String email;
  int id;
  String nome;
  int valorMensal;

  ClientModel(
      {this.chaveLiberacao,
      this.cnpj,
      this.email,
      this.id,
      this.nome,
      this.valorMensal});

  ClientModel.fromJson(Map<String, dynamic> json) {
    chaveLiberacao = json['chave_liberacao'];
    cnpj = json['cnpj'];
    email = json['email'];
    id = json['id'];
    nome = json['nome'];
    valorMensal = json['valor_mensal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chave_liberacao'] = this.chaveLiberacao;
    data['cnpj'] = this.cnpj;
    data['email'] = this.email;
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['valor_mensal'] = this.valorMensal;
    return data;
  }
}
