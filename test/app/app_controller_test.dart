import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:salu_licence_manager/app/app_controller.dart';
import 'package:salu_licence_manager/app/app_module.dart';
import 'package:salu_licence_manager/shared/util/functions.dart';

void main() {
  initModule(AppModule());
  // AppController app;
  //
  setUp(() {
    //     app = AppModule.to.get<AppController>();
  });

  group('AppController Test', () {
    test("Verificar chave gerada", () {
      var chaveGerada = getChave(35, "3322", "295140330000131");
      expect(chaveGerada, isNot(null));
    });
    //   test("First Test", () {
    //     expect(app, isInstanceOf<AppController>());
    //   });

    //   test("Set Value", () {
    //     expect(app.value, equals(0));
    //     app.increment();
    //     expect(app.value, equals(1));
    //   });
  });
}
