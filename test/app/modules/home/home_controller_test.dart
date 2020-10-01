import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salu_licence_manager/app/app_module.dart';

import 'package:salu_licence_manager/app/modules/home/home_controller.dart';
import 'package:salu_licence_manager/app/modules/home/home_module.dart';
import 'package:salu_licence_manager/shared/models/client_model.dart';

void main() {
  initModule(AppModule());
  initModule(HomeModule());
  HomeController home;

  //
  setUp(() {
    home = HomeModule.to.get<HomeController>();
  });

  group('HomeController Test', () {
    test("First Test", () {
      expect(home, isInstanceOf<HomeController>());
    });

    test("Testando chamada do metodo GetAll", () async {
      home.getAllClients();
      List<ClientModel> list = await home.clients;
      expect(list.length, 3);
    });

    test("Testando chamada do metodo GetByCNPJ", () async {
      home.getByCNPJ("37.759.000/0001-80");
      ClientModel client = await home.clients;
      expect(client.id, 1);
    });

    test("Testando chamada do metodo Delete", () async {
      var id = await home.deleteClient(ClientModel(id: 15));

      expect(id["id"], isNot(null));
    });
  });
}
