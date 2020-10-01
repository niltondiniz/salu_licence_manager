import 'package:flutter_modular/flutter_modular.dart';
import 'package:salu_licence_manager/shared/models/client_model.dart';

abstract class IRepository implements Disposable {
  Future<List<ClientModel>> getAll();
  Future<ClientModel> getById(String cnpj);
  Future put(ClientModel clientModel);
  Future delete(ClientModel clientModel);
}
