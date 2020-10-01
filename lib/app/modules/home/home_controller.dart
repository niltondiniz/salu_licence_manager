import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salu_licence_manager/shared/models/client_model.dart';
import 'package:salu_licence_manager/shared/repositories/client_repository.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final ClientRepository repository;

  @observable
  ObservableFuture clients;

  @observable
  ClientModel actualClient;

  _HomeControllerBase(this.repository);

  @action
  // ignore: missing_return
  Future<void> getAllClients() {
    clients = repository.getAll().asObservable();
  }

  @action
  void getByCNPJ(String cnpj) {
    clients = repository.getById(cnpj).asObservable();
  }

  @action
  Future insertClient(ClientModel clientModel) async {
    var id = await repository.put(clientModel);
    return id;
  }

  @action
  Future deleteClient(ClientModel clientModel) async {
    var id = await repository.delete(clientModel);
    return id;
  }
}
