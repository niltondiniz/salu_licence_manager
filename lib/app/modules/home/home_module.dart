import 'package:dio/dio.dart';
import 'package:salu_licence_manager/app/modules/user/user/user_page.dart';
import 'package:salu_licence_manager/shared/repositories/client_repository.dart';
import 'package:salu_licence_manager/shared/util/consts.dart';

import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $HomeController,
        Bind((i) => ClientRepository(i.get())),
        Bind((i) => Dio(BaseOptions(baseUrl: URL_ENDPOINT))),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
