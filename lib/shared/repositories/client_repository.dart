import 'package:dio/dio.dart';
import 'package:salu_licence_manager/shared/models/client_model.dart';
import 'package:salu_licence_manager/shared/repositories/interfaces/IRepository.dart';
import 'package:salu_licence_manager/shared/util/consts.dart';

class ClientRepository implements IRepository {
  final Dio client;

  ClientRepository(this.client);

  @override
  Future delete(ClientModel clientModel) async {
    try {
      final response = await client.post(URL_ENDPOINT, data: {
        "query":
            "mutation Delete {delete_salu_clientes_by_pk(id: ${clientModel.id}){id}}"
      });

      var retorno = response.data["data"]["delete_salu_clientes_by_pk"];
      return retorno;
    } catch (error) {
      throw Exception("Problemas na requisicao: ${error.toString()}");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<List<ClientModel>> getAll() async {
    List<ClientModel> clients = [];

    try {
      final response = await client.post(URL_ENDPOINT, data: {
        "query":
            "query All{salu_clientes(order_by: {nome: asc}){chave_liberacao cnpj email id nome valor_mensal}}"
      });
      for (var json in response.data["data"]["salu_clientes"]) {
        clients.add(ClientModel.fromJson(json));
      }
    } catch (error) {
      throw Exception(error.toString());
    }

    return clients;
  }

  @override
  Future<ClientModel> getById(String cnpj) async {
    ClientModel clientModel;

    try {
      final response = await client.post(URL_ENDPOINT, data: {
        "query":
            "query ByCNPJ{salu_clientes(where: {cnpj: {_eq: \"$cnpj\"}}){chave_liberacao cnpj email id nome valor_mensal}}"
      });

      for (var json in response.data["data"]["salu_clientes"]) {
        clientModel = ClientModel.fromJson(json);
      }
    } catch (error) {
      throw Exception("Problemas na requisicao: ${error.toString()}");
    }

    return clientModel;
  }

  @override
  Future put(ClientModel clientModel) async {
    try {
      final response = await client.post(URL_ENDPOINT, data: {
        "query": clientModel.id == null
            ? "mutation Insert {insert_salu_clientes_one(object:{valor_mensal: \"${clientModel.valorMensal}\", nome: \"${clientModel.nome}\", cnpj: \"${clientModel.cnpj}\", chave_liberacao: \"${clientModel.chaveLiberacao}\", email: \"${clientModel.email}\"}){id}}"
            : "mutation Insert {update_salu_clientes_by_pk(pk_columns: {id:${clientModel.id}}, _set: {valor_mensal: \"${clientModel.valorMensal}\", nome: \"${clientModel.nome}\", cnpj: \"${clientModel.cnpj}\", chave_liberacao: \"${clientModel.chaveLiberacao}\", email: \"${clientModel.email}\"}){id}}"
      });

      var retorno = response.data["data"][clientModel.id == null
          ? "insert_salu_clientes_one"
          : "update_salu_clientes_by_pk"];
      return retorno;
    } catch (error) {
      throw Exception("Problemas na requisicao: ${error.toString()}");
    }
  }
}
