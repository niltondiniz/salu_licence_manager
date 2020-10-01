import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salu_licence_manager/shared/models/client_model.dart';

part 'user_controller.g.dart';

@Injectable()
class UserController = _UserControllerBase with _$UserController;

abstract class _UserControllerBase with Store {
  @observable
  ClientModel actualClient;
}
