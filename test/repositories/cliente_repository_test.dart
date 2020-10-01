import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salu_licence_manager/shared/models/client_model.dart';
import 'package:salu_licence_manager/shared/repositories/client_repository.dart';
import 'package:salu_licence_manager/shared/util/consts.dart';

void main() {
  ClientRepository clientRepository;

  setUp(() {
    clientRepository =
        ClientRepository(Dio(BaseOptions(baseUrl: URL_ENDPOINT)));
  });

  group('AppController Test', () {
    test("Teste consumindo All", () async {
      var clients = await clientRepository.getAll();
      expect(clients.length, greaterThan(3));
    });

    test("Teste consumindo getByCNPJ", () async {
      var client = await clientRepository.getById('37.759.000/0001-80');
      expect(client.id, 1);
    });

    test("Teste inserindo client", () async {
      var client = await clientRepository.put(ClientModel(
        chaveLiberacao: "chave_14",
        cnpj: "29.514.033/0001-45",
        email: "niltondiniz@gmail.com",
        nome: "Isaac Costa Diniz 6",
        valorMensal: 0,
      ));
      expect(client["id"], isNot(null));
    });
  });

  test("Teste atualizando client", () async {
    var client = await clientRepository.put(ClientModel(
      id: 8,
      chaveLiberacao: "chave_8",
      cnpj: "29.514.033/0001-36",
      email: "niltondiniz@gmail.com",
      nome: "Isaac Costa Diniz 6",
      valorMensal: 0,
    ));
    expect(client["id"], isNot(null));
  });

  test("Teste excluindo client", () async {
    var client = await clientRepository.delete(ClientModel(
      id: 18,
      chaveLiberacao: "chave_8",
      cnpj: "29.514.033/0001-36",
      email: "niltondiniz@gmail.com",
      nome: "Isaac Costa Diniz 6",
      valorMensal: 0,
    ));
    expect(client["id"], isNot(null));
  });
}
